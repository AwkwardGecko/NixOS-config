{ config, lib, pkgs, ... }:
{
  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
    settings = {
      bar.layouts = {
        "*" = {
          left = [ "volume" "media" "workspaces" ];
          middle = [ "clock" ];
          right = [ "systray" "bluetooth" "notifications" "dashboard" ];
        };
      };

      notifications = {
        enabled = true;
        autoDismiss = true;
        dismissTimeout = 5000;
      };

      theme = {
        font = {
          name = "JetBrainsMono Nerd Font";
          # Docs/examples tend to use px strings, e.g. "16px" :contentReference[oaicite:2]{index=2}
          size = "1.2rem";
        };
        bar.transparent = true;
      };

      wallpaper.enable = false;
      theming.general.applyWallpapers = false;

      # Use attribute-path style so we never redefine `bar = {...}`
      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = true;
      bar.bluetooth.label = false;
      bar.clock.format = "%H:%M";

      # Not sure `bar.tray.*` is a real key in current docs; keep if you know it works.
      #bar.tray.enable = true;
      #bar.tray.iconSize = 22;

      menus.clock.time = {
        military = true;
        hideSeconds = true;
      };

      menus.clock.weather = {
        unit = "metric";
        key = "cd8270d44cfa4514b6145250260801";
        location = "-31.43127,152.908131";
      };

      menus.dashboard.directories.enabled = false;
      #menus.dashboard.stats.enable_gpu = true; # key path per docs :contentReference[oaicite:3]{index=3}
    };
  };

home.packages = [ pkgs.socat ];

home.file.".local/bin/hyprpanel-hotplug-restart" = {
  executable = true;
  text = ''
    #!${pkgs.bash}/bin/bash
    set -euo pipefail
    shopt -s nullglob

    socks=( "$XDG_RUNTIME_DIR"/hypr/*/.socket2.sock )
    sock="''${socks[0]:-}"
    [[ -S "$sock" ]] || exit 0

    ${pkgs.socat}/bin/socat -u "UNIX-CONNECT:$sock" - | while IFS= read -r line; do
      case "$line" in
        monitoradded*|monitorremoved*)
          ${pkgs.systemd}/bin/systemctl --user restart hyprpanel.service || true
          ;;
      esac
    done
  '';
};

systemd.user.services.hyprpanel-hotplug-restart = {
  Unit = {
    Description = "Restart HyprPanel on monitor hotplug";
    After = [ "graphical-session.target" ];
    PartOf = [ "graphical-session.target" ];
  };
  Service = {
    ExecStart = "%h/.local/bin/hyprpanel-hotplug-restart";
    Restart = "always";
    RestartSec = "1s";
  };
  Install = {
    WantedBy = [ "graphical-session.target" ];
  };
};


}

