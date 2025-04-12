#################
### BLUETOOTH ###
#################

# {
#   config,
#   pkgs,
#   lib,
#   ...
# }:
# {
#
#   #boot.kernelPackages = pkgs.linuxPackages_zen_6_12;
#   boot.extraModprobeConfig = '' options bluetooth disable_ertm=1 '';
#   boot.initrd.kernelModules = [ 
#     "joydev"
#     "uhid"
#     "hid_xpadneo"
#   ];
#   
#   #environment.systemPackages = with pkgs; [
#     #linuxKernel.packages.linux_zen.xpadneo
#     #bluez-experimental
#     #bluez-alsa
#     #bluez-tools
#   #];
#
#   hardware.bluetooth = {
#     enable = true;
#     powerOnBoot = true;
#     package = pkgs.bluez;
#     settings.General = {
#       Privacy = "device";
#       JustWorksRepairing = "always";
#       FastConnectable = "true";
#     };
#   };
#
#   services.blueman.enable = true;
#
#   environment.variables = {
#     "BLUETOOTH_ENABLE_EXPERIMENTAL" = "1";
#   };
#
#
#}



{ config, pkgs, lib, ... }:

{ config, pkgs, lib, ... }:

{
  # Enable Bluetooth support
  networking.bluetooth.enable = true;

  # Package for BlueZ Bluetooth stack
  networking.bluetooth.package = pkgs.bluez;

  # Optional: Disable Enhanced Re-Transmission Mode (ERTM) for compatibility
  networking.bluetooth.extraModprobeConfig = ''
    options bluetooth disable_ertm=1
  '';

  # Enable Bluetooth on boot and configure the Bluetooth service
  services.bluetooth.enable = true;

  # Bluetooth hardware settings
  hardware.bluetooth.enable = true;
}

