#!/usr/bin/env bash
sudo mkdir -p /mnt/steam_raw
sudo mount -o subvolid=5 /dev/disk/by-uuid/249c8bec-3ec2-4b89-8618-748cd918d4ba /mnt/steam_raw
sudo btrfs subvolume create /mnt/steam_raw/@honkai-impact
sudo umount /mnt/steam_raw

