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


{ config, pkgs, ... }:

{
  # Enable Bluetooth support
  networking.bluetooth.enable = true;

  # Set up Bluetooth package (no need for bluezFull anymore)
  networking.bluetooth.package = pkgs.bluez;

  # Ensure the Bluetooth service is powered on at boot
  services.bluetooth.powerOnBoot = true;

  # Optional: Disable ERTM (Enhanced Re-Transmission Mode) for compatibility
  networking.bluetooth.extraModprobeConfig = ''
    options bluetooth disable_ertm=1
  '';

  # Enable the Bluetooth daemon to start automatically
  systemd.services.bluetooth = {
    description = "Bluetooth service";
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/bluetoothd";
    serviceConfig.ExecStop = "${pkgs.bluez}/bin/bluetoothd --shutdown";
    restart = "always";
  };

  # Enable specific Bluetooth modules (you can modify or remove as per your requirements)
  hardware.bluetooth = {
    enable = true;
    # You can add additional settings here, if needed
  };
}

