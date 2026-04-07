{
  config,
  pkgs,
  lib,
  ...
}: {
  # bind to key: scanimage --format=png --output-file ~/Proton-Drive/scan_$(date +%Y-%m-%d_%H_%M_%S).png

  hardware.sane = {
    enable = true;

    extraBackends = with pkgs; [
      #utsushi
      #epkowa
      sane-airscan
    ];

    disabledDefaultBackends = ["escl"];
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
    #simple-scan
    naps2
  ];
}
