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

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_zen.xpadneo
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

  services.blueman.enable = true;

}

# environment.systemPackages = with pkgs; [
#	bluez
#	bluez-alsa
#	bluez-tools
# ];
