#!/usr/bin/env bash
(
  set -euo pipefail
  cd /home/zozano/.dotfiles

  STAMP_DIR="/tmp"
  FLAKE_STAMP="$STAMP_DIR/nix_flake_update.timestamp"
  GC_STAMP="$STAMP_DIR/nix_gc.timestamp"
  OPTIMISE_STAMP="$STAMP_DIR/nix_optimise.timestamp"

  FLAKE_INTERVAL=600        # 10 minutes
  GC_INTERVAL=86400         # 1 day
  OPTIMISE_INTERVAL=604800  # 1 week

  now=$(date +%s)

  stamp_is_stale() {
    local file="$1" interval="$2"
    [[ ! -f "$file" || $(( now - $(< "$file") )) -ge $interval ]]
  }

  # --- Commit locally first (so Nix sees a clean git tree) ---
  git add ./*
  git commit -m "$(date '+%F_%H:%M:%S')" || echo "Nothing to commit."

  # --- Flake update (throttled) ---
  if stamp_is_stale "$FLAKE_STAMP" "$FLAKE_INTERVAL"; then
    echo "Running nix flake update..."
    nix flake update
    echo "$now" > "$FLAKE_STAMP"
  else
    echo "Skipping nix flake update (ran recently)."
  fi

  # --- Rebuild (push only after success, so remote stays known-good) ---
  sudo nixos-rebuild switch --flake .#desktop --show-trace
  echo "Finished rebuilding."

  git push github main || echo "Push failed or nothing to push."
  git status

  # --- Garbage collection (throttled — once per day) ---
  if stamp_is_stale "$GC_STAMP" "$GC_INTERVAL"; then
    echo "Running garbage collection..."
    sudo nix-collect-garbage --delete-older-than 7d
    echo "$now" > "$GC_STAMP"
    echo "Finished deleting garbage older than seven days."
  else
    echo "Skipping garbage collection (ran recently)."
  fi

  # --- Store optimisation (throttled — once per week) ---
  if stamp_is_stale "$OPTIMISE_STAMP" "$OPTIMISE_INTERVAL"; then
    echo "Running nix-store optimisation..."
    sudo nix-store --optimise
    echo "$now" > "$OPTIMISE_STAMP"
    echo "Finished optimising the nix-store."
  else
    echo "Skipping nix-store optimisation (ran recently)."
  fi

  # --- Non-nix updates (failures here shouldn't kill the script) ---
  echo "Beginning flatpak update"
  flatpak update -y || true
  
  echo "Begininng podman update" 
  if command -v podman >/dev/null; then
    podman auto-update || true
  fi
  #sudo podman pull ghcr.io/haveagitgat/tdarr_node:latest
  #sudo systemctl restart podman-tdarr-node

  echo "alejandra formatting"
  alejandra /home/zozano/.dotfiles

  echo "All done."
  sleep 2
) || echo "System update failed with exit code $?."
