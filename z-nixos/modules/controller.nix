#~/.dotfiles/z-nixos/modules/controller.nix
{ config, lib, pkgs, ... }:
let
  gcdb = pkgs.sdl_gamecontrollerdb;
  dbPathPreferred = "${gcdb}/share/sdl2/gamecontrollerdb.txt";
  dbPathAlt       = "${gcdb}/share/gamecontrollerdb/gamecontrollerdb.txt";
  dbPath = if builtins.pathExists dbPathPreferred then dbPathPreferred else dbPathAlt;
in
{
  services.udev.packages = [ pkgs.game-devices-udev-rules ];

  hardware = {
    "steam-hardware".enable = true;
    xone.enable = true;
  };

  environment = {
    systemPackages = [
      gcdb
    ];
    
    variables = {
      SDL_GAMECONTROLLERCONFIG = builtins.readFile dbPath;
    };
  };
}
