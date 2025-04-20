#!/usr/bin/env bash
set -euo pipefail

cd /home/zozano/.dotfiles
nix flake update
sudo nixos-rebuild switch --upgrade --flake /home/zozano/.dotfiles/#z-nixos
