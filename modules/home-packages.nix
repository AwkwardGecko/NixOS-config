{ config, lib, pkgs, ... }:
{
  home-manager.users.zozano = {
    home.packages = with pkgs; [
      #digikam
      #gimp
      #git
      #google-chrome
      #home-assistant-component-tests.tuya
      #hyprpaper
      #hyprshot
      #plasma5Packages.kdeconnect-kde
      #lua
      #lua54Packages.luarocks-nix
      #	nettools
      #	networkmanagerapplet
      #	nwg-look # ???
      #	protonvpn-gui
      #	pyprland # python support for Hyprland
      #	python312Packages.pip
      #	qbittorrent
      qt6Packages.qt6ct # QT support
      #	rofi-wayland
      #qt5ct
      protonup-qt
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
