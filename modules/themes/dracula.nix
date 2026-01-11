###############
### DRACULA ###
###############

{
  config,
  pkgs,
  lib,
  ...
}:
{

  gtk = {
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
  };
}
