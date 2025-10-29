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
    options btusb enable_autosuspend=0
    options hid_xpadneo disable_ff=Y
    options iwlwifi power_save=0
  '';

  #boot.extraModulePackages = [ config.boot.kernelPackages.xpadneo ];
  boot.blacklistedKernelModules = [ "hid_xpadneo" ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.udev.extraRules = ''ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="8087", ATTR{idProduct}=="0029", TEST=="power/control", ATTR{power/control}="on"'';
}
