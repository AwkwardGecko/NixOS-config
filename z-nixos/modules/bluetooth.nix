#~/.dotfiles/z-nixos/modules/bluetooth.nix
{ config, pkgs, lib, ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        ControllerMode = "dual";
        JustWorksRepairing = "always";
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
      LE = {
        Privacy = "off";
      };
    };
  };

  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    bluez
    bluez-tools
    bluez-alsa
  ];

  boot.extraModprobeConfig = ''
    options bluetooth disable_ertm=1 
  '';

  services.udev.extraRules = ''
    # Disable USB autosuspend for Xbox Wireless Controller (045e:0b12)
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="0b12", TEST=="power/control", ATTR{power/control}="on"
  '';


  # boot.extraModulePackages = with config.boot.kernelPackages; [
  #   xpadneo
  # ];
  #


  # boot.initrd.kernelModules = [ 
  #   "joydev"
  #   "uhid"
  #   "hid_xpadneo"
  # ];

  # environment.systemPackages = with pkgs; [
  #   /* xpadneo */
  #   # bluez-experimental
  #   # bluez-alsa
  #   # bluez-tools
  # ];

  # systemd.services.bluetooth.serviceConfig.ExecStart = lib.mkForce [
  #   ""
  #   "${pkgs.bluez}/libexec/bluetooth/bluetoothd --experimental -f /etc/bluetooth/main.conf"
  # ];


  # hardware.enableAllFirmware = true;
  # hardware.xpadneo.enable = true;
}
