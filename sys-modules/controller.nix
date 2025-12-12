#~/.dotfiles/z-nixos/modules/controller.nix
{ config, lib, pkgs, ... }:
{
  services.udev.packages = [ pkgs.game-devices-udev-rules ];

  hardware = {
    #steam-hardware.enable = true;
    #xpad-noone.enable = true;
    xone.enable = true;
  };
}
