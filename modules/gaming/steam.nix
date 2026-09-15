{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extest.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = [pkgs.proton-ge-bin];
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.gamemode.enable = true;

  hardware.graphics.enable32Bit = true;

  home-manager.users.zozano = {
    # systemd.user.services.steam-bigpicture = {
    #   Unit = {
    #     Description = "Autostart Steam in Big Picture mode once XWayland is ready";
    #     After = ["graphical-session.target"];
    #     PartOf = ["graphical-session.target"];
    #   };
    #   Service = {
    #     Type = "simple";
    #     ExecStartPre = "${pkgs.writeShellScript "wait-for-xwayland" ''
    #       until ${pkgs.xset}/bin/xset q >/dev/null 2>&1; do
    #         sleep 0.5
    #       done
    #     ''}";
    #     ExecStart = "${pkgs.steam}/bin/steam -silent %U";
    #     Restart = "on-failure";
    #     RestartSec = 2;
    #   };
    #   Install = {
    #     WantedBy = ["graphical-session.target"];
    #   };
    # };

    home.packages = with pkgs; [
      mangohud
      gnomeExtensions.appindicator
      protonup-qt
    ];

    dconf.settings."org/gnome/shell".enabled-extensions = [
      "appindicatorsupport@rgcjonas.gmail.com"
    ];
  };
}
