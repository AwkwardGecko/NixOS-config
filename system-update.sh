#~/.nix-profile/bin/bash

cd ~/.dotfiles
git add *
git commit -m "$(date '+%F_%H:%M:%S')"
git push github main
sudo nixos-rebuild switch --upgrade --flake ~/.dotfiles/
home-manager switch --upgrade -b backup --flake ~/.dotfiles/
