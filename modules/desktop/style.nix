#############
### STYLE ###
#############
{
  config,
  pkgs,
  lib,
  ...
}: {
  home-manager.users.zozano = {
    home.pointerCursor = {
      enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };

    #gtk.gtk4.theme = null;
  };
}
