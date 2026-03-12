#!/usr/bin/env bash
(
  set -euo pipefail

  cd /home/zozano/.dotfiles
  git add ./*
  git commit -m "$(date '+%F_%H:%M:%S')" 
  git push github main

  # Define the timestamp file
  STAMP_FILE="/tmp/nix_flake_update.timestamp"

  # Check if the file exists and if it's less than 10 minutes old
  if [[ ! -f "$STAMP_FILE" || $(($(date +%s) - $(< "$STAMP_FILE"))) -ge 600 ]]; then
    echo "Running nix flake update..."
    nix flake update
    date +%s > "$STAMP_FILE"
  else
    echo "Skipping nix flake update (ran recently)."
  fi

  nix flake update
  sudo nixos-rebuild switch --flake /home/zozano/.dotfiles/#z-nixos --show-trace
  echo "Finished rebuilding"

  sudo nix-collect-garbage --delete-older-than 7d
  echo "Finished deleting garbage more than seven days old"

  sudo nix-store --optimise
  echo "Finished optimising the nix-store"
  
  #nix-env --delete-generations old

  git status
  flatpak update -y
  
  if command -v podman >/dev/null; then
    podman auto-update --dry-run || true
    podman auto-update || true
  fi
  
  sleep 2  # short pause before closing
) && exit
