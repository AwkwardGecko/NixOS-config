#~/.dotfiles/z-nixos/modules/controller.nix
{ config, lib, pkgs, ... }:
{
  services.udev.packages = [ pkgs.game-devices-udev-rules ];

  hardware = {
    steam-hardware.enable = true;
    xone.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      sdl_gamecontrollerdb
    ];
    variables = {
      SDL_GAMECONTROLLERCONFIG = builtins.readFile "${pkgs.sdl_gamecontrollerdb}/share/sdl2/gamecontrollerdb.txt";
    };
  };
}
