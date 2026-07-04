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
    solaar # mouse fix - for G703 broken on boot, needing to replug the dongle
    liquidctl
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  boot.kernelModules = [
    "nct6775"
    "i2c-dev"
  ];

  programs.coolercontrol.enable = true;

  services.udev = {
    packages = [pkgs.openrgb];
    extraRules = ''
      ACTION=="change", SUBSYSTEM=="block", ENV{ID_SERIAL_SHORT}=="WCJAW4XP", ENV{ID_FS_USAGE}=="filesystem", RUN+="${pkgs.bash}/bin/bash -c 'if ! ${pkgs.util-linux}/bin/findmnt -S /dev/%k >/dev/null; then ${pkgs.hdparm}/bin/hdparm -y /dev/disk/by-id/ata-ST5000LM000-2U8170_WCJAW4XP; fi'"
    '';
  };
  hardware.i2c.enable = true;

  zramSwap.enable = true;
}
