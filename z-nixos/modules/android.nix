{ config, lib, pkgs, ... }:
{
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  programs.kdeconnect.enable = true;
  environment.systemPackages = with pkgs; [
    kdePackages.kio-extras
    gvfs
    libmtp
  ];
}
