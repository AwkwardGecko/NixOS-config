{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    #digikam
    audacity
    ffmpeg
    gimp
    libheif
    qbittorrent
    strawberry
    vlc
    yt-dlp
    jellyfin-media-player
  ];

  home-manager.users.zozano = {
    home.packages = with pkgs; [
      playerctl
      mkvtoolnix # modify video files
      mp3gain # normalize volume of music
    ];

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
  };
}
