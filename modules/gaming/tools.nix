{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bottles
    goverlay
    wine
    # wine-wayland
    # wine-staging
    # winetricks
    # unigine-superposition - don't use. run .exe through steam for Vulkan support
  ];
}
