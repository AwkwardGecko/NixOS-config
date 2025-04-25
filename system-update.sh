#!/usr/bin/env bash
set -euo pipefail

cd /home/zozano/.dotfiles
# git add *
# sleep 2
# git commit -m "$(date '+%F_%H:%M:%S')"
# sleep 2
# git push github main
# sleep 2

nix flake update
sudo nixos-rebuild switch --upgrade --flake /home/zozano/.dotfiles/#z-nixos
