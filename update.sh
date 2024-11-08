#~/.nix-profile/bin/bash

git add ~/.dotfiles/* ~/.dotfiles/.config/*
git commit -m "$(date '+%F_%H:%M:%S')"
git push github main
home-manager switch -b backup --flake ~/.dotfiles/
sudo nixos-rebuild switch --upgrade --flake ~/.dotfiles/
