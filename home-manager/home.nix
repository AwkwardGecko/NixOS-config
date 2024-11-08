###############
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
    inputs.nix-colors.homeManagerModules.default
    # ./modules/applications.nix
    # ./modules/bluez.nix
    # ./modules/fastfetch.nix
    # ./modules/firefox.nix
    ./modules/fish.nix
    ./modules/fonts.nix
    ./modules/git.nix
    ./modules/gtk.nix
    ./modules/hypr.nix
    ./modules/kitty.nix
    ./modules/terminal.nix
    ./modules/mako.nix
    # ./modules/mangohud.nix
    ./modules/neovim.nix
    # ./modules/OpenRGB.nix
    # ./modules/star-rail.nix
    ./modules/waybar/style.nix
    ./modules/waybar/waybar.nix

    #./modules/themes/adwaita-icon-theme.nix	# Icon - Adwaita
    #./modules/themes/bibata-cursors.nix		# Cursor - Bibata-Modern-Classic
    #./modules/themes/dracula.nix
    #./modules/themes/gruvbox-gtk-theme.nix		# Theme - Gruvbox
    #./modules/themes/flat-remix-gtk.nix		# Theme - Flat-Remix-GTK-Grey-Darkest

    #./modules/themes/font-fira-sans.nix
    #./modules/themes/font-sans.nix

  ];

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;

  home.sessionVariables = {
    # QT_QPA_PLATFORMTHEME = 
    # Custom Proton Versions (Glorious Eggroll (GE))
    #STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    # Electron support for Wayland
    NIXOS_OZONE_WL = "1";
    #EDITOR = "nvim";
    #TERMINAL = "kitty";
    # SHELL = "fish";
  };

  home.packages = with pkgs; [
    #	baobab
    #	blueman
    cryptsetup # LUKS support
    #	digikam
    #	dualsensectl
    #	gimp
    #	git
    #	google-chrome
    grimblast
    #	htop
    #	hyprpaper
    #	hyprshot
    #	jellyfin-media-player
    #	plasma5Packages.kdeconnect-kde
    #	lua
    #	lua54Packages.luarocks-nix
    #	lutris
    nautilus # file browser
    #	nettools
    #	networkmanagerapplet
    #	nwg-look # ???
    #	protonvpn-gui
    #	pyprland # python support for Hyprland
    #	python3
    #	python312Packages.pip
    #	pipx	
    #	qbittorrent
    #	qt6ct # QT support
    #	ripgrep # ???
    rofi-wayland
    shotwell
    signal-desktop
    #	vlc
    #	wayland-protocols
    wine
    wine-wayland
    wine-staging
    #	winetricks
    wl-clipboard-rs
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
