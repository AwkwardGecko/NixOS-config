{
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.zozano.services.wlsunset = {
    enable = true;
    latitude = -31.43;
    longitude = 152.91;

    temperature = {
      day = 6500;
      night = 3500;
    };

    systemdTarget = "hyprland-session.target";
  };
}
