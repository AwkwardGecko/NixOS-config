{ config, lib, pkgs, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "~/Pictures/wallpaper/1.jpg" ];
      wallpaper = [ ",~/Pictures/wallpaper/1.jpg" ];
    };
  };

  programs.mpvpaper.enable = true;

}
