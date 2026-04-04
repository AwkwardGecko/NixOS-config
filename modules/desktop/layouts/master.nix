{ config, lib, pkgs, ... }:
{
  home-manager.users.zozano.wayland.windowManager.hyprland.settings = {
    general.layout = "master";
    master = {
      new_status = false;
      mfact = 0.5;
      allow_small_split = false;
    };
  };
}
