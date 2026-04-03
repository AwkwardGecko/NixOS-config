#~/.dotfiles/z-nixos/modules/controller.nix
{
  config,
  lib,
  pkgs,
  ...
}: {
  #services.udev.packages = [ pkgs.game-devices-udev-rules ];

  hardware = {
    #xpad-noone.enable = true;
    #xpad-noone.enable = false;
    # whether to enable The Xpad driver from the Linux kernel with support for Xbox One controllers removed.
    xone.enable = true;
  };
}
