{
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.zozano.wayland.windowManager.hyprland.settings.env = "/run/ydotoold/socket";

  programs = {
    kdeconnect.enable = true;
    ydotool.enable = true;
  };
}
