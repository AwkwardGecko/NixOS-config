{ config, lib, pkgs, ... }:
{
  hardware.enableAllFirmware = true;

  environment.systemPackages = with pkgs; [
    evtest
    hdparm
    lm_sensors  # remove from nvidia.nix and coolercontrol.nix
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

  programs.coolercontrol.enable = true;
  services.hardware.openrgb.enable = true;
}
