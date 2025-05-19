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

}
