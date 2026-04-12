#!/usr/bin/env bash
pos=$(mpc current -f '%position%')
file=$(mpc current -f '%file%')
echo "$file" >> ~/.config/mpd/playlists/delete.m3u
sed -i "\|^${file}$|d" ~/.config/mpd/playlists/global.m3u
mpc next
mpc del "$pos"
systemctl --user restart mpd-mpris
