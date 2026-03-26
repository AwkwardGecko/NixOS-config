{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bottles
    goverlay
    wine
    # unigine-superposition - don't use. run .exe through steam for Vulkan support
  ];
}
