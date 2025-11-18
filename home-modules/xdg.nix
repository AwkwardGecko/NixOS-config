{ config, lib, pkgs, ... }:
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "nautilus.desktop" ];
    };
        associations.removed = {
      "inode/directory" = [ "kitty-open.desktop" ];
    };
  };
}
