{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    protonmail-bridge
    protonmail-bridge-gui
    libnotify
  ];

  #programs.evolution.enable = true;

  programs.kde-pim.kmail = true;
}
