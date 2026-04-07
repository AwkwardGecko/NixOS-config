{
  config,
  pkgs,
  lib,
  ...
}: {
  hardware.sane = {
    enable = true;

    extraBackends = with pkgs; [
      #utsushi
      #epkowa
      sane-airscan
    ];

    disabledDefaultBackends = [ "escl" ];
  };

  services = {
    avahi.enable = true;
    avahi.nssmdns4 = true;
  };

  users.users.zozano.extraGroups = [
    "scanner"
    "lp"
  ];

  environment.systemPackages = with pkgs; [
    simple-scan
  ];
}
