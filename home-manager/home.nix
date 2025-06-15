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
    ./modules/comfui.nix
    ./modules/fish.nix
    #./modules/fonts.nix
    ./modules/gpg.nix
    ./modules/git.nix
    #./modules/gtk.nix
    ./modules/hypr.nix
    ./modules/kitty.nix
    #./modules/terminal.nix
    ./modules/mako.nix
    # ./modules/mangohud.nix
    #./modules/neovim/neovim.nix
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
    #./modules/xmrig.nix
  ];




  home.sessionVariables = {
    #STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d"; # Add custon Proton versions to Steam
    #GTK_THEME = "Adwaita";
    #LD_LIBRARY_PATH = "/usr/lib/x86_64-linux-gnu";
    #LC_ALL = "en_AU.UTF-8";
    #NIXOS_OZONE_WL = "1"; # Wayland Electron support
	#QT_QPA_PLATFORM=xcb;
    #__EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json jellyfinmediaplayer;
  };

	home.file = {
    ".local/share/applications".source = source/local/share/applications;
    #".config/hypr/hypridle.conf".source = source/config/hypr/hypridle-xmrig-off.conf;
    ".local/share/vlc/lua/extensions".source = source/local/share/vlc/lua/extensions;
    ".config/waybar/gputemp.sh".source = source/config/waybar/gputemp.sh;
    # ".config/nsxiv/delete_and_next.sh".source = source/config/nsxiv/delete_and_next.sh;
    # ".config/nsxiv/exec/key-handler".source = source/config/nsxiv/exec/key-handler;
  };


  
  home.packages = with pkgs; [
    baobab        # disk usage analyzer
    #blueberry
    clementine
    cliphist    # wayland clipboard manager
    cryptsetup  # LUKS support
    dex         # run .desktop files from CLI
    #digikam
	  egl-wayland
    fastfetch
    #gimp
    #git
    #google-chrome
    grimblast
	  grc
    home-assistant-component-tests.tuya
	  htop
    #hyprpaper
    #hyprshot
    jellyfin-web
	  #plasma5Packages.kdeconnect-kde
    krusader # file manager 
    krename # batch renamer for krusader
    libva
	  #lua
    #lua54Packages.luarocks-nix
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
    #python312Packages.tinytuya
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
