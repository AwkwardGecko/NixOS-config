{ config, lib, pkgs, ... }:
{
  home-manager.users.zozano = {
    home.packages = with pkgs; [
      cliphist # wayland clipboard manager
      cryptsetup # LUKS support
      dex # run .desktop files from CLI
      #digikam
      egl-wayland
      fastfetch
      #gimp
      #git
      #google-chrome
      grimblast
      grc
      #home-assistant-component-tests.tuya
      htop
      #hyprpaper
      #hyprshot
      #plasma5Packages.kdeconnect-kde
      krusader # file manager
      krename # batch renamer for krusader
      libva
      #lua
      #lua54Packages.luarocks-nix
      mesa
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
      wayland-protocols
      #	wine
      #	wine-wayland
      #	wine-staging
      #	winetricks
      wlroots
      #wl-clipboard-rs
      #xcbeautify # colour support for wayland?
    ];
  };
}
