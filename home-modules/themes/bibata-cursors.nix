##############
### CURSOR ###
##############

{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 16;
  };
}
