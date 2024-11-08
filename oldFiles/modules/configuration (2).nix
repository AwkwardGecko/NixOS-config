# configuration.nix
# sudo nixos-rebuild switch --upgrade --flake ~/.dotfiles/

{ config, pkgs, inputs, ... }: {

	imports = [
		./hardware-configuration.nix
	];

	environment.systemPackages = with pkgs; [
	# System package
	kitty
	fish
	fastfetch
	git
	];

	services = {
		teamviewer.enable = true;



		pipewire = {
			enable = true;			# sound
			pulse.enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
		};
	};

	hardware = {

		enableAllFirmware = true;

		bluetooth.enable = true;
		bluetooth.powerOnBoot = true;
		bluetooth.settings.Policy.AutoEnable = true;
		bluetooth.settings.General = {
			Enable = "Source,Sink,Media,Socket";
			Name = "Hello";
			ControllerMode = "dual";
			FastConnectable = "true";
			Experimental = "true";
			KernelExperimental = "true";
		};

		# pulseaudio.enable = false;	# Enable sound with pipewire.
		nvidia = {
			modesetting.enable = true;
			open = false;			# disable third-party drivers
			nvidiaSettings = true;
			powerManagement.enable = false;
			powerManagement.finegrained = false;
			package = config.boot.kernelPackages.nvidiaPackages.stable;
		};
	};

	programs = {
		
		kdeconnect.enable = true;
		hyprland = {
			enable = true;			# Enable Hyprland
			xwayland.enable = true;
		};
		gamemode.enable = true;
		steam = {
			enable = true;				# Enable Steam
			gamescopeSession.enable = true;
			remotePlay.openFirewall = true;
			dedicatedServer.openFirewall = true;
			localNetworkGameTransfers.openFirewall = true;
		};
	};

	users.users.z = {
		isNormalUser = true;
		description = "z";

		extraGroups = [ 
			"networkmanager" 
			"wheel"
			"gamemode"
		];
	};


	boot = {
		loader.systemd-boot.enable = true;
		loader.efi.canTouchEfiVariables = true;
		initrd.kernelModules = [ "amdgpu" ];
	};

	# xdg.portal = {
	#
	#	enable = true;
	#	extraPortals = [
	#		pkgs.xdg-desktop-portal-hyprland
	#		pkgs.xdg-desktop-portal-gtk
	#	];
	# };

	security.rtkit.enable = true;		# audio realtime kit
	time.timeZone = "Australia/Sydney";
	networking.networkmanager.enable = true;

	virtualisation.docker.enable = true;
	system.autoUpgrade.enable = true;
	system.autoUpgrade.allowReboot = true;
	nixpkgs.config.allowUnfree = true;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	system.stateVersion = "24.05";
	networking.hostName = "z-nixos";
		
	i18n.defaultLocale = "en_AU.UTF-8";
	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_AU.UTF-8";
		LC_IDENTIFICATION = "en_AU.UTF-8";
		LC_MEASUREMENT = "en_AU.UTF-8";
		LC_MONETARY = "en_AU.UTF-8";
		LC_NAME = "en_AU.UTF-8";
		LC_NUMERIC = "en_AU.UTF-8";
		LC_PAPER = "en_AU.UTF-8";
		LC_TELEPHONE = "en_AU.UTF-8";
		LC_TIME = "en_AU.UTF-8";
	};

	};

	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#   enable = true;
	#   enableSSHSupport = true;
	# };

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
}
