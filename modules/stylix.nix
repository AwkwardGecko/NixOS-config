{ config, lib, pkgs, ... }:
{
  stylix = {
    enable = true;
    
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";

    
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        #package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
        name = "JetBrainsMono Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };


    # cursor = {
    #   #package = pkgs.bibata-cursors;
    #   #name = "Bibata-Modern-Classic";
    #   
    #   package = pkgs.kdePackages.breeze;
    #   name = "Breeze_Snow";
    #   
    #   size = 16;
    # };


    #image = pkgs.fetchurl {
    #  url = "https://getwallpapers.com/wallpaper/full/1/4/3/523784.jpg";
    #  hash = "sha256-S/6kgloXiIYI0NblT6YVXfqELApbdHGsuYe6S4JoQwQ=";
    #};
  };


}
