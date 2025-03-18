#!/usr/bin/env bash

cd /home/zozano/.dotfiles
nix flake update
git add *
git commit -m "$(date '+%F_%H:%M:%S')"
git push github main
sudo nixos-rebuild switch --upgrade --flake /home/zozano/.dotfiles/#z-nixos
home-manager switch -b backup --flake /home/zozano/.dotfiles/#
