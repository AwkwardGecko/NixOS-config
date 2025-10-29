#~/.dotfiles/z-nixos/modules/controller.nix
{ config, lib, pkgs, ... }:
let
  gcdb = pkgs.sdl_gamecontrollerdb;
  dbPath = gcdb + "/share/sdl2/gamecontrollerdb.txt";
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
