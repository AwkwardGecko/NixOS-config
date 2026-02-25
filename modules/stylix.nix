{ config, lib, pkgs, ... }:
{
  stylix = {
    enable = true;
    
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    
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
        package = pkgs.jetbrains-mono;
        name = "Jetbrains Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      packages = [
        pkgs.jetbrains-mono
        pkgs.nerd-fonts.jetbrains-mono
      ];
    };

    #image = pkgs.fetchurl {
    #  url = "https://getwallpapers.com/wallpaper/full/1/4/3/523784.jpg";
    #  hash = "sha256-S/6kgloXiIYI0NblT6YVXfqELApbdHGsuYe6S4JoQwQ=";
    #};
  };
}
