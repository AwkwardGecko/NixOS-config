{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/zozano/.steam/root/compatibilitytools.d";
  };

  home-manager.users.zozano = {
    systemd.user.services.steam-bigpicture = {
      Unit = {
        Description = "Autostart Steam in Big Picture mode once XWayland is ready";
        After = ["graphical-session.target"];
        PartOf = ["graphical-session.target"];
      };
      Service = {
        Type = "simple";
        ExecStartPre = "${pkgs.writeShellScript "wait-for-xwayland" ''
          until ${pkgs.xset}/bin/xset q >/dev/null 2>&1; do
            sleep 0.5
          done
        ''}";
        ExecStart = "${pkgs.steam}/bin/steam -silent %U";
        Restart = "on-failure";
        RestartSec = 2;
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };

    home.packages = with pkgs; [
      protonup-qt
    ];
  };
}
