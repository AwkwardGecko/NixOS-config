{ config, lib, pkgs, ... }:
{
  home-manager.users.zozano = {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "image/png" = "imv.desktop";
        "image/jpeg" = "imv.desktop";
        "video/mp4" = "mpv.desktop";
        "video/x-matroska" = "mpv.desktop";
        "application/pdf" = "org.pwmt.zathura.desktop";
        "text/plain" = "gedit.desktop";
        "inode/directory" = [ "nautilus.desktop" ];
      };
    };
  };
}
