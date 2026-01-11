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

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.blacklistedKernelModules = [ "amdgpu" ];

  boot.initrd.kernelModules = [
    "usbhid"
    "btusb"
    "joydev"
  ];
}
