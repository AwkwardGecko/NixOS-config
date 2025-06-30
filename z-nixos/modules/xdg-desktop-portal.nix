{ pkgs, config, lib, ... }:

{
   environment.systemPackages = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-hyprland
   ];
}
