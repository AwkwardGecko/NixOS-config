{ config, lib, pkgs, ... }:
{
  xdg.mime = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "nautilus.desktop" ];
    };
  };
}
