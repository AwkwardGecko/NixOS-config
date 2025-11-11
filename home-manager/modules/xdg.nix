{ config, lib, pkgs, ... }:
{
  home-manager.users.zozano.xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "nautilus.desktop" ];
    };
  };
}
