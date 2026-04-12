find /data/media/music -type f \( -iname '*.mp3' -o -iname '*.flac' -o -iname '*.ogg' -o -iname '*.opus' -o -iname '*.m4a' -o -iname '*.wav' -o -iname '*.wma' \) | sed 's|^/data/media/music/||' | sort | awk '!seen[$0]++' > /tmp/all_tracks.m3u
cat ~/.local/share/mpd/playlists/keep.m3u ~/.local/share/mpd/playlists/delete.m3u > /tmp/exclude.m3u
grep -vxFf /tmp/exclude.m3u /tmp/all_tracks.m3u > ~/.local/share/mpd/playlists/global.m3u
wc -l ~/.local/share/mpd/playlists/global.m3u
rm /tmp/all_tracks.m3u /tmp/exclude.m3u
