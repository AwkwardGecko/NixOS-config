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

  hardware.steam-hardware.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.enable = true;
}
