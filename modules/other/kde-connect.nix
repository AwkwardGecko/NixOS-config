{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    kdeconnect.enable = true;
    ydotool.enable = true;
  };
}
