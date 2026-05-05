{
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.zozano = {
    programs.hyprpanel = {
      enable = true;
      systemd.enable = true;
      settings = {
        bar.layouts = {
          "*" = {
            left = ["volume" "workspaces" "media"];
            middle = ["clock"];
            right = ["systray" "bluetooth" "notifications" "dashboard"];
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
          bar = {
            transparent = true;
            #background = "#1e1e2e";
          };
        };

        wallpaper.enable = false;
        theming.general.applyWallpapers = false;

        # Use attribute-path style so we never redefine `bar = {...}`
        bar = {
          launcher.autoDetectIcon = true;
          workspaces.show_icons = true;
          bluetooth.label = false;
          clock.format = "%H:%M";
          media.truncation_size = 80;
        };

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
        menus.dashboard.stats.enable_gpu = true; # key path per docs :contentReference[oaicite:3]{index=3}
      };
    };

home.packages = [pkgs.socat];

    # Coalesce bursts of monitor add/remove events (common on Nvidia+Wayland
    # when DPMS toggles) into a single hyprpanel restart. Without debouncing,
    # 4-5 events fire in <1s, blowing past systemd's StartLimitBurst=5 and
    # leaving hyprpanel.service in a permanently 'failed (start-limit-hit)'
    # state until manually reset-failed.
    home.file.".local/bin/hyprpanel-hotplug-restart" = {
      executable = true;
      text = ''
        #!${pkgs.bash}/bin/bash
        set -euo pipefail
        shopt -s nullglob

        DEBOUNCE_SEC=2

        socks=( "$XDG_RUNTIME_DIR"/hypr/*/.socket2.sock )
        sock="''${socks[0]:-}"
        [[ -S "$sock" ]] || exit 0

        pending_pid=""

        schedule_restart() {
          # If a restart is already scheduled, kill it and reschedule.
          # The result: we restart exactly once, DEBOUNCE_SEC after the
          # last event in a burst.
          if [[ -n "$pending_pid" ]] && kill -0 "$pending_pid" 2>/dev/null; then
            kill "$pending_pid" 2>/dev/null || true
          fi
          (
            sleep "$DEBOUNCE_SEC"
            ${pkgs.systemd}/bin/systemctl --user reset-failed hyprpanel.service 2>/dev/null || true
            ${pkgs.systemd}/bin/systemctl --user restart hyprpanel.service || true
          ) &
          pending_pid=$!
        }

        # Process substitution keeps the loop in the main shell so
        # pending_pid persists across events.
        while IFS= read -r line; do
          case "$line" in
            monitoradded*|monitorremoved*) schedule_restart ;;
          esac
        done < <(${pkgs.socat}/bin/socat -u "UNIX-CONNECT:$sock" -)
      '';
    };

    systemd.user.services.hyprpanel-hotplug-restart = {
      Unit = {
        Description = "Restart HyprPanel on monitor hotplug (debounced)";
        After = ["graphical-session.target"];
        PartOf = ["graphical-session.target"];
      };
      Service = {
        ExecStart = "%h/.local/bin/hyprpanel-hotplug-restart";
        Restart = "always";
        RestartSec = "1s";
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };

    # Disable the start-limiter on hyprpanel itself. If something does
    # somehow burst-restart it, we'd rather it keep trying than land in
    # 'failed (start-limit-hit)' and require manual intervention.
    systemd.user.services.hyprpanel.Unit.StartLimitIntervalSec = 0;
  };
}
