#~/.dotfiles/z-nixos/modules/bluetooth.nix
{ config, pkgs, lib, ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;

  hardware.enableAllFirmware = true;
  environment.systemPackages = with pkgs; [
    bluez
    bluez-tools
  ];

  hardware.enableRedistributableFirmware = true;
}
