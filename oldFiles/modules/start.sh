#!/usr/bin/env bash

# Wallpaper daemon
swww init &
# set wallpaper
swww img ~/Pictures/wallpapers/gruvbox-mountain-village.png &

# you can install this by adding
# pkgs.networkmanagerapplet to your packages
nm-applet --indicator &

# notification daemon
dunst
