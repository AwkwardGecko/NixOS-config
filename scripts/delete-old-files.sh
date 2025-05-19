#~/usr/bin/env bash

sudo nix-collect-garbage -d --delete-older-than 7d
sudo nix store gc
nix profile wipe-history --older-than 7d
sudo rm -rf ~/.cache/nix
sudo find /nix/var/nix/gcroots/auto -xtype l -delete
sudo nix-store --optimise
