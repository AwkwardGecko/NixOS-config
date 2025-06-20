#~/.dotfiles/z-nixos/modules/theme.nix
{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    libadwaita
  ];
}
