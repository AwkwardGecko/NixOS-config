############
### TMUX ###
############

{
  config,
  pkgs,
  lib,
  ...
}:
{
  home-manager.users.zozano = {
programs.tmux.enable = true;
  };
}
