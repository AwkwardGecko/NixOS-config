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
    #kdePackages.kmail
    #kdePackages.kdepim-addons
  ];

  #programs.evolution.enable = true;

  programs.kde-pim = {
    enable = true;
    kmail = true;
  };
}
