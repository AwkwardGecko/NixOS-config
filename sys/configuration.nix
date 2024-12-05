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
  hardware.xpadneo.enable = true;

  imports = [
    ./hardware-configuration.nix

    ./modules/audio.nix # audio
    ./modules/autologin.nix # 100%
    ./modules/bluetooth.nix # bluetooth
    ./modules/boot.nix # configure kernel modules
    ./modules/cachix.nix # cachix
    ./modules/docker.nix
    ./modules/filesystem.nix
    ./modules/firefox.nix
    ./modules/gamemode.nix
    ./modules/hypr.nix
    ./modules/internationalisation.nix
    ./modules/openrgb.nix
    ./modules/polkit.nix
    #./modules/nixvim.nix
    ./modules/nvidia.nix
    #./modules/star-rail.nix
    ./modules/steam.nix
    ./modules/teamviewer.nix
    ./modules/users.nix
    ./modules/xserver.nix
  ];

  #programs = {

  # firefox.enable = true;
  # kdeconnect.enable = true;
  #gamemode.enable = true;
  #};

  #services = {
  # teamviewer.enable = true;
  #hardware.openrgb.enable = true;
  #};

  #virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    glibc
    glibc_memusage
    bootiso
    #btmon
    #bluez-experimental
    #bluez-alsa
    #bluez-tools
    docker
    docker-compose
    bazel
    digikam
    cudatoolkit
    gnome-disk-utility
    libheif
    libheif.out
    gparted
    gperftools
    qbittorrent
    gimp
    nixd # Language SP (LSP) server
    nixfmt-rfc-style # used to format styles - $ nixfmt <file>.nix
    unixtools.ifconfig
    nettools
    iproute2
    #haskellPackages.cuda
    #haskellPackages.torch
    python310
    pyenv
    sc-controller # steam controller support
    sshfs
    strawberry
    rustdesk
    pavucontrol
    wine
    vlc
    wine-staging
    wine-wayland
  ];
}
