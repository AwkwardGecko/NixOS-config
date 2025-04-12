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

{
  # Ensure the Bluetooth package and service are enabled
  networking.enableBluetooth = true;

  # Bluetooth package (we'll use bluez)
  networking.bluetooth.package = pkgs.bluez;

  # Enable Bluetooth on boot
  services.bluetooth.enable = true;

  # Optional: Disable Enhanced Re-Transmission Mode (ERTM) for compatibility
  networking.bluetooth.extraModprobeConfig = ''
    options bluetooth disable_ertm=1
  '';

  # Make sure Bluetooth starts at boot
  systemd.services.bluetooth = {
    description = "Bluetooth service";
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/bluetoothd";
    serviceConfig.ExecStop = "${pkgs.bluez}/bin/bluetoothd --shutdown";
    restart = "always";
  };

  # Enable the Bluetooth hardware
  hardware.bluetooth.enable = true;
}

