{ pkgs, config, lib, ... }:

{
  wayland.windowManager.hyprland.enable = true;
  services.xdg-desktop-portal = {
     enable = true;
     wlr.enable = true;
  };

}
