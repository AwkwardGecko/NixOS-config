{
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.zozano = {
    services.wayle = {
      enable = true;
      settings = {
        general = {
          font-sans = "JetBrainsMono Nerd Font";
          font-mono = "JetBrainsMono Nerd Font";
        };

        # Per-monitor bar layout. Array-of-tables: one entry per monitor.
        # Volume on the left; network + microphone omitted entirely;
        # systray + dashboard restored on the right.
        bar = {
          layout = [
            {
              monitor = "*";
              left = ["volume" "hyprland-workspaces" "media" "ram" "custom-vram"];
              center = ["clock"];
              right = ["systray" "bluetooth" "notifications" "dashboard"];
            }
          ];
          background-opacity = 100;
        };

        modules = {
          clock.format = "%H:%M";

          media.label-max-length = 80;

          bluetooth.label-show = false;

          ram = {
            poll-interval-ms = 2000;
            format = "{{ percent }}%";
            icon-name = "ld-memory-stick-symbolic";
          };

          weather = {
            provider = "open-meteo";
            location = "-31.43127,152.908131";
            units = "metric";
          };

          # Custom VRAM module. Referenced in the layout as "custom-vram".
          # Command outputs plain text "usedMiB/totalMiB"; {{ output }} renders it.
          custom = [
            {
              id = "vram";
              command = "${config.hardware.nvidia.package.bin}/bin/nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader,nounits | awk -F', ' '{printf \"%dMiB/%dMiB\", $1, $2}'";
              interval-ms = 2000;
              icon-name = "ld-gpu-symbolic";
              format = "{{ output }}";
            }
          ];
        };

        notifications = {
          popup-duration = 5000;
        };

        wallpaper.engine-enabled = false;
      };
    };

    home.packages = with pkgs; [socat];

    # --- hotplug debounce (unchanged) ---
    home.file.".local/bin/wayle-hotplug-restart" = {
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
          if [[ -n "$pending_pid" ]] && kill -0 "$pending_pid" 2>/dev/null; then
            kill "$pending_pid" 2>/dev/null || true
          fi
          (
            sleep "$DEBOUNCE_SEC"
            ${pkgs.systemd}/bin/systemctl --user reset-failed wayle.service 2>/dev/null || true
            ${pkgs.systemd}/bin/systemctl --user restart wayle.service || true
          ) &
          pending_pid=$!
        }
        while IFS= read -r line; do
          case "$line" in
            monitoradded*|monitorremoved*) schedule_restart ;;
          esac
        done < <(${pkgs.socat}/bin/socat -u "UNIX-CONNECT:$sock" -)
      '';
    };

    systemd.user.services.wayle-hotplug-restart = {
      Unit = {
        Description = "Restart wayle on monitor hotplug (debounced)";
        After = ["graphical-session.target"];
        PartOf = ["graphical-session.target"];
      };
      Service = {
        ExecStart = "%h/.local/bin/wayle-hotplug-restart";
        Restart = "always";
        RestartSec = "1s";
      };
      Install = {WantedBy = ["graphical-session.target"];};
    };

    systemd.user.services.wayle.Unit.StartLimitIntervalSec = 0;
  };
}
