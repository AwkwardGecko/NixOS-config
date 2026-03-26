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
}
