{ config, lib, pkgs, ... }:
{
  home.file."bin/star-rail" = {
    text = ''
    #!/usr/bin/env bash
    set -euo pipefail

    BASE="$HOME/.var/app/moe.launcher.the-honkers-railway-launcher/data/honkers-railway-launcher"
    PREFIX="$BASE/prefix"
    RUNNERDIR="$BASE/runners/spritz-wine-tkg-staging-wow64-10.15-6"  # TODO: change to your actual GE-Proton dir

    # 1. Proton / Wine environment like Honkers
    export WINEPREFIX="$PREFIX"
    export STEAM_COMPAT_DATA_PATH="$PREFIX"
    export SteamAppId="0"
    export WINEARCH="win64"
    export WINEFSYNC="1"

    # 2. Your fullscreen FSR tweaks (from /proc/27098)
    export WINE_FULLSCREEN_FSR="1"
    export WINE_FULLSCREEN_FSR_MODE="balanced"
    export WINE_FULLSCREEN_FSR_STRENGTH="2"

    # 3. Libraries for this Proton build (pattern from upstream logs)
    export GST_PLUGIN_PATH="$RUNNERDIR/files/lib64/gstreamer-1.0:$RUNNERDIR/files/lib/gstreamer-1.0"
    export LD_LIBRARY_PATH="$RUNNERDIR/files/lib:$RUNNERDIR/files/lib64:$RUNNERDIR/files/lib64/wine/x86_64-unix:$RUNNERDIR    /files/lib/wine/i386-unix"

    # 4. Go to the game directory (your /proc/27098 cwd)
    cd "$BASE/HSR"

    # 5. Run the same exe + arguments you saw in CMDLINE
    #    Using the Proton runner Honkers downloaded
    exec bash -c "gamemoderun python3 '$RUNNERDIR/proton' waitforexitandrun \
      'Z:\\home\\$USER\\.var\\app\\moe.launcher.the-honkers-railway-launcher\\data\\honkers-railway-launcher\\HSR\\StarRail.exe' \
      -screen-fullscreen 0 -popupwindow -window-mode exclusive"
    EOF
    '';
    executable = true;
  };
}
