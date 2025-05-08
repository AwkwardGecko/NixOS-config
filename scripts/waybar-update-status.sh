#!/usr/bin/env bash

OUT=$(sudo nixos-rebuild dry-activate --flake ~/.dotfiles#$(hostname) 2>&1)

if [[ -z "$OUT" ]]; then
  # No rebuild needed
  echo '{"text": "  ", "class": "clean"}'
else
  # Rebuild needed
  echo '{"text": "  ", "class": "dirty"}'
fi

