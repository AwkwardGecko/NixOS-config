#!/usr/bin/env bash
file=$(mpc current -f '%file%')
echo "$file" >> ~/.config/mpd/playlists/delete.m3u
sed -i "\|^${file}$|d" ~/.config/mpd/playlists/global.m3u
mpc del 0
