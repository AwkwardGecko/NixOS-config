#################
### BLUETOOTH ###
#################

{
  config,
  pkgs,
  lib,
  ...
}:
{

  #boot.kernelPackages = pkgs.linuxPackages_zen_6_12;
  boot.extraModprobeConfig = '' options bluetooth disable_ertm=1 '';
  boot.initrd.kernelModules = [ 
    "joydev"
    "uhid"
    "hid_xpadneo"
  ];
  
  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_zen.xpadneo
    #bluez-experimental
    #bluez-alsa
    #bluez-tools
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    package = pkgs.bluezFull;
    settings.General = {
      Privacy = "device";
      JustWorksRepairing = "always";
      FastConnectable = "true";
    };
  };

  services.blueman.enable = true;

  environment.variables = {
    "BLUETOOTH_ENABLE_EXPERIMENTAL" = "1";
  };


}
