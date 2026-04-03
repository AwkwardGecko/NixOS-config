################
### GAMEMODE ###
################
{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.gamemode = {
    enable = true;
  };
}
