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

  boot.extraModulePackages = [ config.boot.kernelPackages.xpadneo ];

  boot.extraModprobeConfig = '' options bluetooth disable_ertm=1 '';
  boot.initrd.kernelModules = [ "joydev" "uhid"];
  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_zen.xpadneo
    #bluez-experimental
    #bluez-alsa
    #bluez-tools
  ];

  #  hardware.xone.enable = true;



  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General = {
      Privacy = "device";
      JustWorksRepairing = "always";
      Class = "0x000100";
      FastConnectable = "true";
      # ControllerMode = "dual";
    };
  };
}
