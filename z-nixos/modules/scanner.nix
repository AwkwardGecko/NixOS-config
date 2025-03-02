{ config, pkgs, lib, ... }:

{
  hardware.sane = {
    enable = true;
    
    extraBackends = [
      pkgs.utsushi
    ];
  };

  services.udev.packages = [
      pkgs.utsushi
  ];

  users.users.zozano.extraGroups = [
    "scanner"
    "lp"
  ];

  environment.systemPackages = with pkgs; [
    simple-scan
  ];

}
