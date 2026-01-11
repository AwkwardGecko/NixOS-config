###############
### ADWAITA ###
###############

{
  config,
  pkgs,
  lib,
  ...
}:
{

  gtk.iconTheme = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
  };

}
