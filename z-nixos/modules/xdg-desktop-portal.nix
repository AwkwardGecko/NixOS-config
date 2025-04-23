{ pkgs, config, lib, ... }:

{
  wayland.windowManager.hyprland.enable = true;
  services.sdg-desktop-portal = {
     enable = true;
     wlr.enable = true;
  };

}
