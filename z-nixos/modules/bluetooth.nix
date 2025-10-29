#~/.dotfiles/z-nixos/modules/bluetooth.nix
{ config, pkgs, lib, ... }:
{
  hardware.bluetooth = {
    enable = false;
    powerOnBoot = true;
    
    settings = {
      General = {
        Experimental = true;
        ControllerMode = "dual";
        JustWorksRepairing = "confirm";
        FastConnectable = false;
      };
    };
  };

  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    bluez
    bluez-tools
    ts
  ];

  # Xbox controller: kernel driver (xpadneo) for better rumble/LED/battery over BT
  hardware.xpadneo.enable = true;
  hardware.enableRedistributableFirmware = true;

  boot.extraModprobeConfig = ''
    options bluetooth disable_ertm=1
    options hid_xpadneo disable_ff=Y
  '';

  #boot.extraModulePackages = [ config.boot.kernelPackages.xpadneo ];
  boot.blacklistedKernelModules = [ "hid_xpadneo" ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };


services.udev.extraRules = ''
  ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="8087", ATTR{idProduct}=="0029", TEST=="power/control", ATTR{power/control}="on"
'';

  #services.udev.extraRules = ''
    # Disable USB autosuspend for Xbox Wireless Controller (045e:0b12)
  #  ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="0b12", TEST=="power/control", ATTR{power/control}="on"
    
    # Also disable USB autosuspend for the Intel Bluetooth adapter (8087:0026)
  #  ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="8087", ATTR{idProduct}=="0026", TEST=="power/control", ATTR{power/control}="on"

  #'';
  # --- Xpadneo ---

  # kernelHeaders must match running kernel
  # boot.extraModulePackages = with config.boot.kernelPackages; [
  #   xpadneo
  # ];
  #
  # # optional: auto-reload on Bluetooth hot-plug
  # systemd.services."xpadneo-reload" = {
  #   after = [ "bluetooth.service" ];
  #   description = "Reload xpadneo after bluetooth restart";
  #   wantedBy = [ "bluetooth.service" ];
  #   serviceConfig.ExecStart = "${pkgs.kmod}/bin/modprobe hid_xpadneo";
  # };

  # boot.initrd.kernelModules = [ 
  #   "joydev"
  #   "uhid"
  #   "hid_xpadneo"
  # ];

}
