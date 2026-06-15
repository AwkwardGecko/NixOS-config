{
  config,
  lib,
  pkgs,
  ...
}: let
  jellyfin-inhibit = pkgs.writeShellScript "jellyfin-inhibit" ''
    set -euo pipefail

    PLAYERCTL="${pkgs.playerctl}/bin/playerctl"
    SYSTEMD_INHIBIT="/run/current-system/sw/bin/systemd-inhibit"
    inhibit_pid=""

    cleanup() {
      [ -n "$inhibit_pid" ] && kill "$inhibit_pid" 2>/dev/null || true
    }
    trap cleanup EXIT INT TERM

    is_jellyfin_playing() {
      # Match any jellyfin MPRIS player reporting Playing
      $PLAYERCTL --player=jellyfin,JellyfinDesktop,jellyfinmediaplayer status 2>/dev/null \
        | grep -q "Playing"
    }

    while true; do
      if is_jellyfin_playing; then
        if [ -z "$inhibit_pid" ] || ! kill -0 "$inhibit_pid" 2>/dev/null; then
          # Hold one continuous idle+sleep inhibit; sleep infinity keeps it alive
          $SYSTEMD_INHIBIT --what=idle:sleep \
            --who="jellyfin-inhibit" \
            --why="Jellyfin is playing" \
            ${pkgs.coreutils}/bin/sleep infinity &
          inhibit_pid=$!
        fi
      else
        if [ -n "$inhibit_pid" ] && kill -0 "$inhibit_pid" 2>/dev/null; then
          kill "$inhibit_pid" 2>/dev/null || true
          inhibit_pid=""
        fi
      fi
      ${pkgs.coreutils}/bin/sleep 5
    done
  '';
in {
  home-manager.users.zozano = {
    systemd.user.services.jellyfin-inhibit = {
      Unit = {
        Description = "Hold a stable idle inhibitor while Jellyfin is playing";
        After = ["graphical-session.target"];
        PartOf = ["graphical-session.target"];
      };
      Service = {
        ExecStart = "${jellyfin-inhibit}";
        Restart = "on-failure";
        RestartSec = 5;
      };
      Install.WantedBy = ["graphical-session.target"];
    };
  };
}
