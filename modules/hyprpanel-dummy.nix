{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
  };
}
