#####################	sudo nixos-rebuild switch --upgrade --flake ~/.dotfiles/
### CONFIGURATION ###
#####################

{
  config,
  pkgs,
  libs,
  inputs,
  ...
}:
{
  system.stateVersion = "24.05";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  swapDevices = [ { label = "swap"; } ];
  networking.hostName = "z-nixos";
  networking.networkmanager.enable = true;
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  imports = [
    ./hardware-configuration.nix

    ./modules/audio.nix
    ./modules/autologin.nix
    ./modules/bluetooth.nix
    ./modules/boot.nix
    ./modules/cachix.nix
	./modules/filesystem.nix
    ./modules/hypr.nix
    ./modules/internationalisation.nix
	./modules/polkit.nix
    #./modules/nixvim.nix
    ./modules/nvidia.nix
    #./modules/star-rail.nix
    ./modules/steam.nix
    ./modules/users.nix
    ./modules/xserver.nix
  ];

  programs = {

    firefox.enable = true;
    # kdeconnect.enable = true;
    gamemode.enable = true;
  };
 

  services = {
	teamviewer.enable = true;
    hardware.openrgb.enable = true;
  };

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [

glibc
glibc_memusage
bootiso
    docker
    docker-compose
    bazel
	digikam
    cudatoolkit
    gnome-disk-utility
	jellyfin
	jellyfin-ffmpeg
	jellyfin-web
	jellyfin-media-player
	libheif
	libheif.out
	gparted
  	gperftools
  	qbittorrent
	gimp
    nixd # Language SP (LSP) server
    nixfmt-rfc-style # used to format styles - $ nixfmt <file>.nix
    #haskellPackages.cuda
    #haskellPackages.torch
    python310
    pyenv
	strawberry
    pavucontrol
    wine
	vlc
    wine-staging
    wine-wayland
  ];
}
