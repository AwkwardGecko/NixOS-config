{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    evince
    gedit
    gnome-calculator
    nomacs
    onlyoffice-desktopeditors
  ];
}
