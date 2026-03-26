{ config, lib, pkgs, ... }:
{
  hardware.enableAllFirmware = true;

  environment.systemPackages = with pkgs; [
    cups
    evtest
    hdparm
    lm_sensors  # remove from nvidia.nix and coolercontrol.nix
    pciutils
    smartmontools
    usbutils
    upower  
  ];
}
