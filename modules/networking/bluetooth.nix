{
  config,
  pkgs,
  lib,
  ...
}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.Experimental = true;
  };

  #services.blueman.enable = true;

  #hardware.enableAllFirmware = true;
  environment.systemPackages = with pkgs; [
    bluez
    bluez-tools
  ];

  hardware.enableRedistributableFirmware = true;
}
