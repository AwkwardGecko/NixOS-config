{ config, lib, pkgs, ... }:
{
  services.flatpak.enable = true;
  
  programs.honkers-railway-launcher.enable = true;

}
