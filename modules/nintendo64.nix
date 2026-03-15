{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cen64
    mupen64plus
  ];
}
