{ config, pkgs, lib, ... }:

{
  hardware.sane = {
    enable = true;
    
    extraBackends = with pkgs; [
      utsushi
      epkowa
    ];
  };

  services = {
    udev.packages = [
      pkgs.utsushi
    ];
    avahi.enable = true;
    avahi.nssmdns = true;
  };

  users.users.zozano.extraGroups = [
    "scanner"
    "lp"
  ];

  environment.systemPackages = with pkgs; [
    simple-scan
  ];

}
