################
### HOME.NIX ###
################

# nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
# nix-channel --update
# nix-shell '<home-manager>' -A install
# home-manager switch -b backup --flake ~/nix/

{
  config,
  inputs,
  pkgs,
  ...
}:

{

  imports = [
    # ./modules/applications.nix
    #./modules/cursor.nix
    ./modules/fish.nix
    ./modules/fonts.nix
    ./modules/git.nix
    #./modules/gtk.nix
    ./modules/hypr.nix
    ./modules/kitty.nix
    #./modules/terminal.nix
    ./modules/mako.nix
    # ./modules/mangohud.nix
    #./modules/nixvim.nix
    ./modules/neovim/neovim.nix
    # ./modules/OpenRGB.nix
    ./modules/ranger.nix
    # ./modules/star-rail.nix
    ./modules/style.nix
    # ./modules/swaync.nix
    ./modules/rofi.nix
    ./modules/tmux.nix
    ./modules/waybar.nix
    # ./modules/waybar/mechabar.nix
    #./modules/xserver.nix
  ];

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d"; # Add custon Proton versions to Steam
    #NIXOS_OZONE_WL = "1"; # Wayland Electron support
	#QT_QPA_PLATFORM=xcb;
	#__EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json jellyfinmediaplayer;
  };

	home.file = {
    ".local/share/applications".source = source/local/share/applications;
    ".local/share/vlc/lua/extensions".source = source/local/share/vlc/lua/extensions;
	};

  home.packages = with pkgs; [
	baobab # disk usage analyzer
    #blueberry
    clementine
    cliphist
    cryptsetup # LUKS support
    #	digikam
    easymp3gain
    fastfetch
    #	gimp
    #	git
    #	google-chrome
    grimblast
	grc
    haskellPackages.MusicBrainz
    home-assistant-component-tests.tuya
	htop
    #	hyprpaper
    #	hyprshot
    jellyfin-web
	#	plasma5Packages.kdeconnect-kde
    krusader # file manager 
    krename # batch renamer for krusader
    libva
	#	lua
    #	lua54Packages.luarocks-nix
    #	lutris
    mesa
    mp3gain # normalize volume of music
    mkvtoolnix #modify video files 
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
   	qt6ct # QT support
   	ripgrep # something for nvim
    #	rofi-wayland
    jellyfin-media-player
	#qt5ct
	protonup-qt
    python312Packages.tinytuya
    shotwell
    signal-desktop
    #	vlc
	egl-wayland
    wayland-protocols
    #	wine
    #	wine-wayland
    #	wine-staging
    #	winetricks
	wlroots
    #wl-clipboard-rs
    #xcbeautify # colour support for wayland? 
  ];

  programs.home-manager.enable = true;
  home.username = "zozano"; # Home Manager needs a bit of information about
  home.homeDirectory = "/home/zozano"; # you and the paths it should manage.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  #];
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/z/etc/profile.d/hm-session-vars.sh
}
