{
  config,
  lib,
  pkgs,
  ...
}: {
  hardware.enableAllFirmware = true;

  environment.systemPackages = with pkgs; [
    evtest
    hdparm
    lm_sensors
    pciutils
    smartmontools
    usbutils
    upower
    liquidctl
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot.kernelModules = ["nct6775"];

  programs.coolercontrol.enable = true;

  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
    startupProfile = "Zozano";
  };

  systemd.user.services.openrgb-profile = {
    description = "Apply OpenRGB profile";
    wantedBy = [ "graphical-sessioon.target" ];
    after = [ "openrgb.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.openrgb}/bin/openrgb --profile Zozano";
    };
  };

  zramSwap.enable = true;
}
