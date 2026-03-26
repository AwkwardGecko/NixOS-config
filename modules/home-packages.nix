{ config, lib, pkgs, ... }:
{
  home-manager.users.zozano = {
    home.packages = with pkgs; [
      cryptsetup # LUKS support
      dex # run .desktop files from CLI
      #digikam
      fastfetch
      #gimp
      #git
      #google-chrome
      grc
      #home-assistant-component-tests.tuya
      htop
      #hyprpaper
      #hyprshot
      #plasma5Packages.kdeconnect-kde
      krusader # file manager
      krename # batch renamer for krusader
      #lua
      #lua54Packages.luarocks-nix
      mp3gain # normalize volume of music
      mkvtoolnix # modify video files
      nautilus # file browser
      #	nettools
      #	networkmanagerapplet
      #	nwg-look # ???
      playerctl
      #	protonvpn-gui
      #	pyprland # python support for Hyprland
      python3
      #	python312Packages.pip
      pipx
      #	qbittorrent
      qt6Packages.qt6ct # QT support
      ripgrep # something for nvim
      #	rofi-wayland
      #qt5ct
      protonup-qt
      #python312Packages.tinytuya
      #SDL2
      shotwell
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
