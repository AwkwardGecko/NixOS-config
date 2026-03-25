{ config, lib, pkgs, ... }:
{
  xdg.desktopEntries.jellyfin-opener = {
    name = "Jellyfin Media Player Opener";
    exec = "jellyfin-desktop %u";
    type = "Application";
    noDisplay = true;
    mimeType = [ "x-scheme-handler/jmp" ];
  };

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/jmp" = "jellyfin-opener.desktop";
  };
}
