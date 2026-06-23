#~/.dotfiles/z-nixos/modules/controller.nix
{
  config,
  lib,
  pkgs,
  ...
}: {
  #services.udev.packages = [ pkgs.game-devices-udev-rules ];

  hardware = {
    xone.enable = true; # dongle support
    xpadneo.enable = true; # bluetooth support
  };
}
