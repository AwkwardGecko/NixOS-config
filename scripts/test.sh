# Check if MPD sees the tracks
mpc playlist | wc -l
# Try playing one directly
mpc add "$(head -1 ~/.local/share/mpd/playlists/global.m3u)"
mpc play
# Check MPD's database
mpc listall | wc -l
