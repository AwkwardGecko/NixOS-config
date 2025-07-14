#############
### STEAM ###
#############

{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.steam = {
    enable = true;
    #gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  hardware = {
    steam-hardware.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/steam/steam/root/compatibilitytools.d";
  };

  environment.systemPackages = with pkgs; [
    xdg-user-dirs
  ];
}
