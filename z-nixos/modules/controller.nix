#~/.dotfiles/z-nixos/modules/controller.nix
{ config, lib, pkgs, ... }:
{
  hardware.steam-hardware.enable = true;

  hardware.xone.enable = true;

  environment.variables = {
    SDL_GAMECONTROLLERCONFIG = builtins.readFile "${pkgs.sdl2}/share/sdl2/gamecontrollerdb.txt";
  };
}
