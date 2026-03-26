{ config, lib, pkgs, ... }:
{
  # programs.nix-ld.enable = true; # resolve library issues for stable diffusion

  environment.systemPackages = with pkgs; [
    zlib
    libGL
    gcc-unwrapped
  ];
}
