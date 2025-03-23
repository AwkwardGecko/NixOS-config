#!/usr/bin/env bash

cd /home/zozano/.dotfiles
nix flake update
sudo nixos-rebuild switch --upgrade --flake /home/zozano/.dotfiles/#z-nixos
fc-cache -f -v
git add *
git commit -m "$(date '+%F_%H:%M:%S')"
git push github main
