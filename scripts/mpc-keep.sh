#!/usr/bin/env bash
file=$(mpc current -f '%file%')
mpc del 0
echo "$file" >> ~/.config/mpd/playlists/keep.m3u
