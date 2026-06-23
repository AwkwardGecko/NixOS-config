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

        bar = {
          layout = [
            {
              monitor = "*";
              left = ["volume" "hyprland-workspaces" "ram" "custom-vram" "custom-crafty" "media"];
              center = ["clock"];
              right = ["systray" "weather" "notifications" "dashboard"];
            }
          ];
          background-opacity = 0;
        };

        modules = {
          clock.format = "%H:%M";

          media.label-max-length = 80;

          bluetooth.label-show = false;

          volume = {
            scroll-up = "wayle audio output-volume +5";
            scroll-down = "wayle audio output-volume -5";
          };

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

          custom = [
            {
              id = "vram";
              command = "${config.hardware.nvidia.package.bin}/bin/nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader,nounits | awk -F', ' '{printf \"%02d%%\", ($1/$2)*100}'";
              interval-ms = 2000;
              icon-name = "ld-cpu-symbolic";
              format = "{{ output }}";
            }
            {
              id = "crafty";
              command = "${pkgs.jq}/bin/jq -r '.text // empty' ~/.cache/crafty-battery.json 2>/dev/null";
              interval-ms = 10000;
              icon-name = "ld-wind-symbolic";
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
    # home.file.".local/bin/wayle-hotplug-restart" = {
    #   executable = true;
    #   text = ''
    #     #!${pkgs.bash}/bin/bash
    #     set -euo pipefail
    #     shopt -s nullglob
    #     DEBOUNCE_SEC=2
    #     socks=( "$XDG_RUNTIME_DIR"/hypr/*/.socket2.sock )
    #     sock="''${socks[0]:-}"
    #     [[ -S "$sock" ]] || exit 0
    #     pending_pid=""
    #     schedule_restart() {
    #       if [[ -n "$pending_pid" ]] && kill -0 "$pending_pid" 2>/dev/null; then
    #         kill "$pending_pid" 2>/dev/null || true
    #       fi
    #       (
    #         sleep "$DEBOUNCE_SEC"
    #         ${pkgs.systemd}/bin/systemctl --user reset-failed wayle.service 2>/dev/null || true
    #         ${pkgs.systemd}/bin/systemctl --user restart wayle.service || true
    #       ) &
    #       pending_pid=$!
    #     }
    #     while IFS= read -r line; do
    #       case "$line" in
    #         monitoradded*|monitorremoved*) schedule_restart ;;
    #       esac
    #     done < <(${pkgs.socat}/bin/socat -u "UNIX-CONNECT:$sock" -)
    #   '';
    # };

    #   systemd.user.services.wayle-hotplug-restart = {
    #     Unit = {
    #       Description = "Restart wayle on monitor hotplug (debounced)";
    #       After = ["graphical-session.target"];
    #       PartOf = ["graphical-session.target"];
    #     };
    #     Service = {
    #       ExecStart = "%h/.local/bin/wayle-hotplug-restart";
    #       Restart = "always";
    #       RestartSec = "1s";
    #     };
    #     Install = {WantedBy = ["graphical-session.target"];};
    #   };
    #
    #   systemd.user.services.wayle.Unit.StartLimitIntervalSec = 0;
  };
}
