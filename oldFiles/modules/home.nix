
	################
	### HOME.NIX ###
	################

	# to install
	# nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
	# nix-channel --update
	# nix-shell '<home-manager>' -A install
	# home-manager switch -b backup --flake ~/.dotfiles/



	{ config, pkgs, lib, ... }:

{	
	imports = [
		./modules/applications.nix
		./modules/bluez.nix
		./modules/fastfetch.nix
		./modules/firefox.nix
		./modules/fish.nix
		./modules/git.nix
		./modules/gtk.nix
		./modules/hypr.nix
		./modules/kitty.nix
		./modules/mangohud.nix
		./modules/nvim.nix
		./modules/OpenRGB.nix
		#./modules/star-rail.nix
		./modules/waybar.nix
	];
	
	home.sessionVariables = {
		# QT_QPA_PLATFORMTHEME = 
		# Custom Proton Versions (Glorious Eggroll (GE))
		STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
		# Electron support for Wayland
		NIXOS_OZONE_WL = "1";
		EDITOR = "nvim";
		TERMINAL = "kitty";
	};

	home.packages = with pkgs; [
		baobab
		blueman
		cryptsetup # LUKS support
		digikam
		dualsensectl
		gimp
		git
		google-chrome
		htop
		hyprpaper
		hyprshot
		jellyfin-media-player
		plasma5Packages.kdeconnect-kde
		lua
		lua54Packages.luarocks-nix
		lutris
		nautilus # file browser
		nettools
		networkmanagerapplet
		nwg-look # ???
		protonvpn-gui
		pyprland # python support for Hyprland
		python3
		python312Packages.pip
		pipx	
		qbittorrent
		qt6ct # QT support
		ripgrep # ???
		rofi-wayland
		shotwell
		signal-desktop
		vlc
		wayland-protocols
		wine
		wine-wayland
		wine-staging
		winetricks
		wl-clipboard-rs
	];

	home.pointerCursor = {
		gtk.enable = true;
		package = pkgs.bibata-cursors;
		name = "Bibata-Modern-Classic";
		size = 16;
	};

	services.mako.enable = true;
	programs.home-manager.enable = true;
	nixpkgs.config.allowUnfree = true;
	home.username = "z"; # Home Manager needs a bit of information about
	home.homeDirectory = "/home/z"; # you and the paths it should manage.
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
