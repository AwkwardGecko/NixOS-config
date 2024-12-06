####################
### GRUVBOX-PLUS ###
####################

{
  config,
  pkgs,
  lib,
  ...
}:
{

  gtk.iconTheme = {
    name = "Gruvbox Plus";
    package = pkgs.gruvbox-plus-icons;
  };
}
