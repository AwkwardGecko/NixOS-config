#~/.nix-profile/bin/bash

git add * .config/
git commit -m "another commit"
git push github main
home-manager switch -b backup --flake ~/.dotfiles/

sudo nixos-rebuild switch --upgrade --flake ~/.dotfiles/
