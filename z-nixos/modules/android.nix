{ config, lib, pkgs, ... }:
{
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  programs.kdeconnect.enable = true;
  environment.systemPackages = with pkgs; [
    kio-extras
    gvfs
    libmtp
  ];
}
