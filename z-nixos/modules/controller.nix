#~/.dotfiles/z-nixos/modules/controller.nix
{ config, lib, pkgs, ... }:
let
  sdlDb = pkgs.sdl2-gamecontrollerdb or null;
in
{
  hardware.steam-hardware.enable = true;

  hardware.xone.enable = true;

  environment.variables = lib.mkIf (sdlDb != null) {
    SDL_GAMECONTROLLERCONFIG = builtins.readFile "${pkgs.sdlDb}/share/sdl2/gamecontrollerdb.txt";
  };
}
