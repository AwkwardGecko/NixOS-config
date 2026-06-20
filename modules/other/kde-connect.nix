{
  config,
  lib,
  pkgs,
  ...
}: {

  home-manager.users.zozano.home.sesstionVariables.YDOTOOL_DOCKER = "/run/ydotoold/socket";

  programs = {
    kdeconnect.enable = true;
    ydotool.enable = true;
  };
}
