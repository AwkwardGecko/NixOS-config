#~/.dotfiles/z-nixos/modules/alejandra.nix
{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    alejandra
  ];
}
