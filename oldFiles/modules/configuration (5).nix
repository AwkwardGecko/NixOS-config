# Zozano's Configuration

{ config, pkgs, inputs, ... }:

{
	nixpkgs.config.allowUnfree = true;		# Allow unfree packages

	environment.systemPackages = with pkgs; [
		adwaita-icon-theme
		adwaita-qt
		adwaita-qt6
		ayatana-ido
		alsa-utils
		baobab
		cryptsetup
		dolphin
		dunst # notification daemon
		fastfetch
		firefox
		fish
		fishPlugins.gruvbox
		gedit
		git
		glibc
		gperftools
		gnome-keyring
		gruvbox-gtk-theme
		gtk3
		gtk4
		handbrake
		home-manager
		htop
		hyprpaper # wallpaper utility
		jellyfin
		jellyfin-media-player
		jellyfin-ffmpeg
		jellyfin-web	
		kitty
		libadwaita
		loupe
		lutris
		lsof
		lxappearance
		mangohud
		mesa
		nautilus
		papirus-icon-theme
		pamixer
		patchelf
		pavucontrol
		polkit
		protonup
		# protonvpn-gui
		python3
		qbittorrent
		qt5.qtwayland
		qt6.qmake
		qt6.qtwayland
		redshift
		rofi-wayland # window switcher / dmenu replacement
		shattered-pixel-dungeon
		signal-desktop
		simple-scan
		teamviewer
		udisks
		util-linux
		utsushi
		vimPlugins.gruvbox-nvim
		vimPlugins.indent-blankline-nvim
		vimPlugins.lazy-nvim
		vimPlugins.nvim-treesitter
		vimPlugins.tokyonight-nvim
		vaapiIntel
		vaapiVdpau
		vulkan-loader
		vlc
		vulkan-tools
		vulkan-validation-layers
		waybar
		winetricks
		wineWowPackages.stable
		wineWowPackages.waylandFull
		wofi # application launcher
		xdg-desktop-portal-hyprland
		yazi
		inputs.swww.packages.${pkgs.system}.swww
	];


	#	services.jellyfin.enable = true;
	#	services.jellyfin.openFirewall = true;

	services.hardware.openrgb.enable = true;

	programs.neovim = {
		enable = true;
		defaultEditor = true;
	};

	environment.sessionVariables = {
		STEAM_EXTRA_COMPAT_TOOLS_PATHS =
			"\${HOME}/.steam/root/compatibilitytools.d";
	};

	services.xserver.enable = true;				# X11 enable X11
	services.xserver.videoDrivers = ["nvidia"];		# X11 Nvidia driver
	services.xserver.xkb.layout = "us";			# X11 keyboard layout
	services.xserver.xkb.variant = "";			
	services.displayManager.autoLogin.enable = true;	# enable autologin
	services.displayManager.autoLogin.user = "z";		# enable autologin for user
	services.teamviewer.enable = true;
	programs.hyprland.enable = true;			# hyprland
	programs.hyprland.xwayland.enable = true;		# x-wayland
	programs.gamemode.enable = true;

	programs.steam = {
		enable = true;
		gamescopeSession.enable = true;
		remotePlay.openFirewall = true;
		dedicatedServer.openFirewall = true;
		localNetworkGameTransfers.openFirewall = true;
	};

	hardware.nvidia = {
		modesetting.enable = true;					# nvidia kernal mode
		open = false;
		nvidiaSettings = true;
		package = config.boot.kernelPackages.nvidiaPackages.stable;	# nvidia driver
	};

	hardware.graphics = {
		enable = true;					# open-gl
		enable32Bit = true;
	};

	# hardware.pulseaudio.support32Bit = true;

	security.rtkit.enable = true;			# realtime kit (sound priority)
	services.pipewire.enable = true;		# pipewire
	services.pipewire.alsa.enable = true;		# alsa
	services.pipewire.alsa.support32Bit = true;	# alsa 32 bit
	services.pipewire.pulse.enable = true;		# pulse
	services.pipewire.jack.enable = true;		# jack

	users.users.z.isNormalUser = true;				# user
	users.users.z.description = "fuckoff";				# user description
	users.users.z.extraGroups = [ 
		"networkmanager"
		"wheel"
		"scanner"
		"lp"
		"gamemode"
	];

	networking.networkmanager.enable = true;			# network manager
	boot.loader.systemd-boot.enable = true;				# boot (systemd)
	boot.loader.efi.canTouchEfiVariables = true;			# boot
	xdg.portal.enable = true;					# XDG Portal
	xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];	# XDG Portal extras

	i18n.defaultLocale =  "en_US.UTF-8";
	i18n.extraLocaleSettings = {
		LC_ADDRESS =		"en_AU.UTF-8";
		LC_IDENTIFICATION =	"en_AU.UTF-8";
		LC_MEASUREMENT =	"en_AU.UTF-8";
		LC_MONETARY =		"en_AU.UTF-8";
		LC_NAME =		"en_AU.UTF-8";
		LC_NUMERIC =		"en_AU.UTF-8";
		LC_PAPER =		"en_AU.UTF-8";
		LC_TELEPHONE =		"en_AU.UTF-8";
		LC_TIME =		"en_AU.UTF-8";
	};

	home-manager = {	# also pass inputs to home-manager modules
		extraSpecialArgs = {inherit inputs;};
		users = { "z" = import ./home.nix; };
	};

	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;

	hardware.sane.enable = true;	# scanner support
	hardware.sane.extraBackends = [ pkgs.epkowa pkgs.utsushi ];
	services.udev.packages = [ pkgs.utsushi ];

	fonts = {
		fontconfig.enable = true;
		fontDir.enable = true;
		enableGhostscriptFonts = true;
		packages = with pkgs; [
			corefonts
			dejavu_fonts
			font-awesome
			inconsolata
			ubuntu_font_family
			nerdfonts
			siji
		];
	};

	imports = [
		./hardware-configuration.nix
		inputs.home-manager.nixosModules.default
	];

	fileSystems."/steam" = {
		device = "/dev/disk/by-partlabel/Steam";
		fsType = "btrfs";
	};

	system.autoUpgrade.enable = true;
	system.autoUpgrade.allowReboot = true;

	swapDevices = [ { device = "/dev/disk/by-partlabel/swap"; } ];
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	time.timeZone = "Australia/Sydney";
	networking.hostName = "z-nixos";
	system.stateVersion = "24.05";

}
