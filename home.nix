{ config, lib, inputs, pkgs, ... }:
{
  imports = [
    ./modules/hyprpanel.nix
    ./modules/kitty.nix
    ./modules/jellyfin-media-player-home.nix
    ./modules/lutris.nix
    ./modules/mangohud.nix
    ./modules/ranger.nix
    ./modules/star-rail.nix
    ./modules/style.nix
    ./modules/rofi.nix
    ./modules/tmux.nix
    ./modules/wallpaper.nix
  ];

  # to add home modules to sys modules, start with:
  # home-manager.users.zozano = { };

  systemd.user.startServices = "sd-switch";

  home.sessionVariables = {
    SDL_VIDEODRIVER = "wayland"; # Wayland backends for common stacks
    QT_QPA_PLATFORM = "wayland";
    MOZ_ENABLE_WAYLAND = 1;
    NIXOS_OZONE_WL = 1; # Enables Wayland (Ozone) backend in Chromium/Electron apps.
    ELECTRON_OZONE_PLATFORM_HINT = "auto";

    # controllers / SDL
    #SDL_GAMECONTROLLERCONFIG =
    #  builtins.readFile "${pkgs.sdl2}/share/sdl2/gamecontrollerdb.txt"; # Injects a controller mapping database that SDL uses to identify how your gamepad buttons map to standard Xbox-style layouts.

    # Video Acceleration on Nvidia
    LIBVA_DRIVER_NAME = "nvidia"; # VA-API hardware video decode backend.
    __GLX_VENDOR_LIBRARY_NAME = "nvidia"; # Tells GLVND (OpenGL vendor dispatcher) to use Nvidia’s driver instead of Mesa’s.

    # Wine / Proton
    #WINE_FULLSCREEN_FOCUS_MODE = 1; # Lets Wine maintain focus properly when alt-tabbing fullscreen games under Wayland.

    # Portals & theming (Wayland-friendly file pickers, etc.)
    #GTK_USE_PORTAL = 1;
    #QT_QPA_PLATFORMTHEME = "qt5ct";

    # Pipewire
    SDL_AUDIODRIVER = "pipewire";

  };

  #home.file = {
    #".local/share/applications".source = source/local/share/applications;
    #".config/hypr/hypridle.conf".source = source/config/hypr/hypridle-xmrig-off.conf;
    #".local/share/vlc/lua/extensions".source = source/local/share/vlc/lua/extensions;
    #".config/waybar/gputemp.sh".source = source/config/waybar/gputemp.sh;
    # ".config/nsxiv/delete_and_next.sh".source = source/config/nsxiv/delete_and_next.sh;
    # ".config/nsxiv/exec/key-handler".source = source/config/nsxiv/exec/key-handler;
  #};

  home.packages = with pkgs; [
    baobab
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

  home.enableNixpkgsReleaseCheck = false;

  programs.home-manager.enable = true;
  home.username = "zozano"; 
  home.homeDirectory = "/home/zozano"; 
  home.stateVersion = "24.05"; 
}
