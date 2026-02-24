{ config, lib, pkgs, ... }:
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    base24Scheme = "${pkgs.base24-schemes}/share/themes/gruvbox-dark.yaml";

    #image = pkgs.fetchurl {
    #  url = "https://getwallpapers.com/wallpaper/full/1/4/3/523784.jpg";
    #  hash = "sha256-S/6kgloXiIYI0NblT6YVXfqELApbdHGsuYe6S4JoQwQ=";
    #};
  };
}
