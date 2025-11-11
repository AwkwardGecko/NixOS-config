{ config, lib, pkgs, ... }:
{
  home.file.".local/bin/video-wallpapers.sh" = {
    text = ''
      #!/usr/bin/env bash

      VID_DIR="$HOME/Videos/wallpapers"
      DELAY=300  # seconds per video
      OUTPUT="ALL"

      while true; do
        # Randomize order. If no files, wait and retry.
        vids=("$VID_DIR"/*.mp4)
        if [ ! -e "''${vids[0]}" ]; then
          sleep 60
          continue
        fi

        for vid in $(printf "%s\n" "$VID_DIR"/*.mp4 | shuf); do
          [ -f "$vid" ] || continue
          pkill -x mpvpaper 2>/dev/null || true
          mpvpaper "$OUTPUT" "$vid" -o "no-audio --loop=yes --hwdec=auto" &
          sleep "$DELAY"
        done
      done
    '';
    executable = true;
  };
}
