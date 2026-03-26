{ config, lib, pkgs, ... }:
{
  home-manager.users.zozano = {
    home.packages = with pkgs; [
      #	networkmanagerapplet
      #	nwg-look # ???
      #	protonvpn-gui
      #	pyprland # python support for Hyprland
      #	python312Packages.pip
      #	qbittorrent
      #	rofi-wayland
      #qt5ct
      #python312Packages.tinytuya
      #SDL2
      #	vlc
      #	wine
      #	wine-wayland
      #	wine-staging
      #	winetricks
      #wl-clipboard-rs
      #xcbeautify # colour support for wayland?
    ];
  };
}
