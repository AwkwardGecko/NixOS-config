# Find where MPD actually looks for playlists
grep -i playlist /nix/store/0asksih2jg3cvk3nwdwczwbc77c485v1-mpd.conf
# Check if there's a stale copy there
ls ~/.local/share/mpd/playlists/
wc -l ~/.local/share/mpd/playlists/global.m3u 2>/dev/null
