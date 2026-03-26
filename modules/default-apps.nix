{ config, lib, pkgs, ... }:
{
  home-manager.users.zozano = {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = [ "nautilus.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
      };
    };
  };
}
