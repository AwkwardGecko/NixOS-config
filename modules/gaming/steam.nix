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
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/steam/steam/root/compatibilitytools.d";
  };

  home-manager.users.zozano = {
    home.packages = with pkgs; [
      protonup-qt
    ];
  };
}
