############
### BOOT ###
############

{
  config,
  pkgs,
  lib,
  ...
}:
{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.initrd.kernelModules = [
    "usbhid"
    "btusb"
    "joydev"
  ];
}
