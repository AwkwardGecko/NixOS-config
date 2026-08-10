{ config, lib, pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
    };
    displayManager = {
      gdm.enable = true;
      autoLogin = {
        enable = true;
        user = "zozano";
      };
    };
    desktopManager.gnome.enable = true;
  };
}
