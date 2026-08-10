{ config, lib, pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
    };
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
}
