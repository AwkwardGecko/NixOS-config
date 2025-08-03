#~/usr/bin/env bash


sudo du -h --max-depth=1 / | sort -h
sudo du -h --max-depth=1 /nix | sort -h
sudo du -sh /nix/var/log/nix/drvs
sudo rm -rf /nix/var/log/nix/drvs/*

journalctl --disk-usage                 # see the damage
sudo journalctl --vacuum-time=7d        # keep just a week
sudo journalctl --vacuum-size=100M      # and cap it

sudo nix-store --gc --print-roots | \
  while read -r root _; do
    [ -e "$root" ] || sudo rm -f "$root"
  done
sudo nix-store --gc                       # run GC again

sudo nix profile wipe-history --profile /nix/var/nix/profiles/per-user/root --older-than 7d
for u in $(ls /nix/var/nix/profiles/per-user); do
  nix profile wipe-history --profile /nix/var/nix/profiles/per-user/$u --older-than 7d
done

sudo rm -rf /var/cache/nix/*
sudo rm -rf /root/.cache/nix/*


sudo nix-collect-garbage -d --delete-older-than 7d
sudo nix store gc
nix profile wipe-history --older-than 7d
sudo rm -rf ~/.cache/nix
sudo find /nix/var/nix/gcroots/auto -xtype l -delete
sudo nix-store --optimise

nix path-info -rSh /run/current-system   # how big is the closure you actually need
df -h /                                  # see what you reclaimed

