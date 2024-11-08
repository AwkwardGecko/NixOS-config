#~/.nix-profile/bin/bash

git add *
git commit -m "another commit"
git push github main
home-manager switch -b backup --flake ~/.dotfiles/
