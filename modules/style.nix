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
    #gtk = {
      #enable = true;
      #gtk4.theme = null;
      # x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    #};
  };

  # gtk = {
  #   enable = true;
  #
  #   theme = {
  #     package = pkgs.flat-remix-gtk;
  #     name = "Flat-Remix-GTK-Grey-Darkest";
  #   };
  #
  #   iconTheme = {
  #     package = pkgs.papirus-icon-theme;
  #     name = "Adwaita";
  #   };
  #
  #   font = {
  #     name = "Sans";
  #     size = 11;
  #   };
}
