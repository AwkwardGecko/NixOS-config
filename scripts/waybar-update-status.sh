#!/usr/bin/env bash

set -euo pipefail

# Get current system path
CURRENT=$(readlink -f /run/current-system)

# Get what would be activated
TARGET=$(sudo -n nixos-rebuild dry-activate --flake ~/.dotfiles#z-nixos --log-format raw 2>/dev/null |
  grep -o '/nix/store/[^ ]*' | head -n1)

if [[ "$CURRENT" != "$TARGET" ]]; then
  echo '{"text": "  ", "class": "dirty"}'
else
  echo '{"text": "  ", "class": "clean"}'
fi

