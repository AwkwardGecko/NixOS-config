#!/usr/bin/env bash
pos=$(mpc current -f '%position%')
file=$(mpc current -f '%file%')
echo "$file" >> ~/.local/share/mpd/playlists/keep.m3u
grep -vxF "$file" ~/.local/share/mpd/playlists/global.m3u > /tmp/global_tmp.m3u
mv /tmp/global_tmp.m3u ~/.local/share/mpd/playlists/global.m3u
mpc next
mpc del "$pos"
