{ config, lib, pkgs, ... }:
{
  home.file.".local/bin/video-wallpapers.sh" = {
    text = ''
      #!/usr/bin/env bash

      VID_DIR="$HOME/Videos/wallpapers"
      DELAY=300  # seconds per video (5 minutes)
      OUTPUT="ALL"

      while true; do
        for vid in "$VID_DIR"/*.mp4; do
          [ -f "$vid" ] || continue
          pkill -x mpvpaper 2>/dev/null
          mpvpaper "$OUTPUT" "$vid" -o "no-audio --loop=yes --hwdec=auto" &
          sleep "$DELAY"
        done
      done
    '';
    executable = true;
  };
}
