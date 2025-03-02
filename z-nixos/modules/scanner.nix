{ config, pkgs, lib, ... }:

{
  hardware.sane = {
    enable = true;
    
    extraBackends = [
      pkgs.utushi
    ];
  };

  services.udev.packages = [
      pkgs.utushi
  ];

  users.users.zozano.extraGroups = [
    "scanner"
    "lp"
  ];

  environment.systemPackages = with pkgs; [
    simple-scan
  ];

}
