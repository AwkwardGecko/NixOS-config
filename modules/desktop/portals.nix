{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    evince
    gedit
    gnome-calculator
    nomacs
    onlyoffice-desktopeditors
    #krusader
    krename # batch renamer for krusader
    nautilus # file browser
    shotwell
  ];
}
