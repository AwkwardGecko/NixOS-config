{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    kdeconnect.enable = true;
    programs.ydotool.enable = true;
  };
}
