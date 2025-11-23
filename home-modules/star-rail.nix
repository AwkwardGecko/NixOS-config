{ config, lib, pkgs, ... }:
{
  home.file."bin/star-rail" = {
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      BASE="$HOME/.var/app/moe.launcher.the-honkers-railway-launcher/data/honkers-railway-launcher"
      PREFIX="$BASE/prefix"
      RUNNERDIR="$BASE/runners/spritz-wine-tkg-staging-wow64-10.15-6"

      # Wine environment like Honkers
      export WINEPREFIX="$PREFIX"
      export WINEARCH="win64"
      export WINEFSYNC="1"

      # FSR tweaks from the running process
      export WINE_FULLSCREEN_FSR="1"
      export WINE_FULLSCREEN_FSR_MODE="balanced"
      export WINE_FULLSCREEN_FSR_STRENGTH="2"

      # Use the runner's libs
      export LD_LIBRARY_PATH="$RUNNERDIR/lib64:$RUNNERDIR/lib:$RUNNERDIR/lib32"

      # Game directory (your /proc/.../cwd)
      cd "$BASE/HSR"

      # Run Star Rail with Wine from this runner, non-exclusive mode
      exec "$RUNNERDIR/bin/wine64" \
        "$BASE/HSR/StarRail.exe" \
        -screen-fullscreen 0 -popupwindow -window-mode borderless
    '';
    executable = true;
  };
}

