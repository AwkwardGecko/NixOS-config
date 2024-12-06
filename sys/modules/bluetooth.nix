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

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings.General = {
      Experimental = true;
      ControllerMode = "dual";
    };
  };

  services.blueman.enable = true;

}

# environment.systemPackages = with pkgs; [
#	bluez
#	bluez-alsa
#	bluez-tools
# ];
