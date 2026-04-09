#!/usr/bin/env bash
file=$(mpc current -f '%file%')
echo "$file" >> ~/.config/mpd/playlists/keep.m3u
mpc current --wait
mpc del 0
