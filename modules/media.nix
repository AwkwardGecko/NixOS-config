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
  ];

  home-manager.users.zozano = {
    home.packages = with pkgs; [
      playerctl
      mkvtoolnix # modify video files
      mp3gain # normalize volume of music
    ];
  };
}
