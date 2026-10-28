#!/usr/bin/env bash

set -Eeuo pipefail

cd /home/zozano/.dotfiles

REMOTE="github"
BRANCH="main"
FLAKE_TARGET=".#desktop"

trap 'echo "System update failed at line $LINENO." >&2' ERR

# Refuse to stage oversized files.
oversized=$(find . -type f -size +50M -not -path './.git/*')
if [[ -n "$oversized" ]]; then
  echo "Refusing to update — oversized files detected:" >&2
  echo "$oversized" >&2
  exit 1
fi

# Stage local work so new files are visible to Nix and protected by autostash.
git add -A

# Incorporate remote changes before updating.
git pull --rebase --autostash "$REMOTE" "$BRANCH"

# Format before building and committing.
echo "Formatting Nix files..."
alejandra -q .

# Update all flake inputs.
echo "Updating flake inputs..."
nix flake update

# Include formatting, lockfile, and any other resulting changes.
git add -A

# Rebuild and activate the complete NixOS and Home Manager configuration.
echo "Rebuilding NixOS..."
sudo nixos-rebuild switch --flake "$FLAKE_TARGET" --show-trace
echo "Finished rebuilding."

# Commit only after the configuration has built and activated successfully.
if ! git diff --cached --quiet; then
  git commit -m "$(date '+%F_%H:%M:%S')"
else
  echo "No configuration changes to commit."
fi

# Back up the exact configuration that was rebuilt successfully.
git push "$REMOTE" "$BRANCH"

# Flatpak updates are separate from the NixOS configuration and Git backup.
flatpak_failed=0
echo "Updating Flatpaks..."
if ! flatpak update -y; then
  echo "Warning: Flatpak update failed." >&2
  flatpak_failed=1
fi

echo "Final repository status:"
git status

if (( flatpak_failed )); then
  echo "NixOS update and Git backup completed, but the Flatpak update failed." >&2
  exit 1
fi

echo "All done."
