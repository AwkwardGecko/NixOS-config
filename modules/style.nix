#############
### STYLE ###
#############

{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };
}
