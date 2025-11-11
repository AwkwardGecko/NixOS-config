{ config, lib, pkgs, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      wallpaper = [ ",~/Pictures/wallpaper/1.jpg" ];
    };
  };
}
