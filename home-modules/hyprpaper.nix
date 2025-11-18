{ config, lib, pkgs, ... }:
{
  services.hyprpaper = {
    enable = false;
    settings = {
      preload = [ "~/Pictures/wallpaper/1.jpg" ];
      wallpaper = [ ",~/Pictures/wallpaper/1.jpg" ];
    };
  };

  programs.mpvpaper.enable = true;

}
