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
  };

  programs.solarr.enable = true;

  boot.kernelModules = [
    "nct6775"
    "i2c-dev"
  ];

  programs.coolercontrol.enable = true;

  services.udev = {
    packages = [pkgs.openrgb];
    extraRules = ''
      ACTION=="add", SUBSYSTEM=="block", KERNEL=="sd?", ENV{ID_SERIAL_SHORT}=="WCJAW4XP", RUN+="${pkgs.hdparm}/bin/hdparm -B 127 -S 60 /dev/disk/by-id/ata-ST5000LM000-2U8170_WCJAW4XP"
    '';
  };

  hardware.i2c.enable = true;

  zramSwap.enable = true;
}
