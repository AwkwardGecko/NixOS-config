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

  boot.initrd.kernelModules = [
    "usbhid"
    "btusb"
    "joydev"
    "xpad"
  ];
}
