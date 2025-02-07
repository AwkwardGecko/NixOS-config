#~/.nix-profile/bin/bash

cd ~/.dotfiles
git add *
git commit -m "$(date '+%F_%H:%M:%S')"
git push github main
home-manager switch -b backup --flake /home/zozano/.dotfiles/#zozano
#sudo nixos-rebuild switch --upgrade --flake ~/.dotfiles/
