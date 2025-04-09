#####################	sudo nixos-rebuild switch --upgrade --flake ~/.dotfiles/
### CONFIGURATION ###
#####################

{ config, pkgs, libs, inputs, ... }:
{
  # Automatic updating
  system = {
    autoUpgrade = {
      enable = true;
      dates = "daily";
    };
    stateVersion = "24.05";
  };

  security.sudo.extraRules = [
    {
      users = [ "zozano" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/nixos-rebuild";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  # Automatic cleanup
  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };

    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  swapDevices = [ { label = "swap"; } ];
  services.custom-ssh-agent.enable = true;

  networking.hostName = "z-nixos";
  networking.networkmanager.enable = true;
  networking.interfaces.enp10s0.macAddress = "04:42:1A:A7:FD:1F";
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  security.doas.enable = true;
  programs.ssh.startAgent = true;
  programs.npm.enable = true;

  programs.nix-ld.enable = true; # resolve library issues for Stable Diffusion

  programs.coolercontrol.enable = true;


  aagl.enableNixpkgsReleaseBranchCheck = false;

  imports = [
    ./hardware-configuration.nix
    ./modules/audio.nix # audio
    ./modules/autologin.nix # 100%
    ./modules/bluetooth.nix # bluetooth
    ./modules/boot.nix # configure kernel modules
    ./modules/cachix.nix # cachix
    #./modules/cron.nix
    ./modules/docker.nix
    ./modules/filesystem.nix
    ./modules/firefox.nix
    ./modules/fonts.nix
    ./modules/gamemode.nix
    ./modules/hypr.nix
    ./modules/hyprland_instance_sig.nix
    ./modules/internationalisation.nix
    #./modules/ollama.nix
    ./modules/openrgb.nix
    ./modules/polkit.nix
    ./modules/monero.nix
    #./modules/miniconda3.nix
    #./modules/nixvim.nix
    ./modules/nvidia.nix
    #./modules/reload-usb.nix
    ./modules/scanner.nix
    ./modules/ssh.nix
    ./modules/steam.nix
    #./modules/systemd-timers.nix
    ./modules/teamviewer.nix
    ./modules/users.nix
    ./modules/xserver.nix
    ./modules/whisperai.nix
    ./modules/wine.nix
  ];

  environment.systemPackages = with pkgs; [

    alsa-lib
    atk
    bazel
    binutils_nogold
    #bluez-alsa
    #bluez-experimental
    #bluez-tools
    bootiso
    brave
    #btmon
    btrfs-progs
    cairo
    cargo
    cargo-auditable-cargo-wrapper
    cargo-c
    cargo-deb
    cargo-rr
    conda
    clinfo
    crane
    crane
    crate2nix
    cups
    dbus
    dcap
    digikam
    docker
    docker-compose
    evince # document viewer
    evtest # outputs key and button codes
    expat
    ffmpeg
    gcc
    gcc-unwrapped # for stable diffusion
    gimp
    git
    glib
    glibc
    glibc_memusage
    gperftools # for stable diffusion
    gnome-calculator
    gnome-disk-utility
    gparted
    gperftools
    gtk3
    gtkd
    gwe
    icu
    iproute2
    koboldcpp
    libGL
    libdrm
    libglvnd # for stable diffusion
    libheif
    libheif.out
    libpcap # 2025-02-19 for star rail relic scorer: Fribbels Honkai Star Rail Optimizer
    libsecret
    libxkbcommon
    libz
    lld
    llvmPackages.bintools
    lutris
    mesa
    nettools
    nixd # Language SP (LSP) server
    nixfmt-rfc-style # used to format styles - $ nixfmt <file>.nix
    nodePackages.nodejs
    nspr
    nss
    nvtopPackages.nvidia
    onlyoffice-bin
    openssl # For updater / reliquary-archiver
    ostree # package for flatpak
    pango
    parted
    pavucontrol
    pcapfix
    pkg-config # for reliquary-archiver
    playonlinux
    protobuf
    pxattr # allows execution of .app files
    pyenv
    python311
    python311Packages.pip
    python311Packages.pyasyncore
    python311Packages.xattr
    python312Packages.libpcap
    qbittorrent
    rclone
    rpm-ostree # package for flatpak
    rustc
    rustc
    rustup # for reliquary-archiver
    rustup-toolchain-install-master
    sc-controller # steam controller support
    signal-desktop
    smartmontools
    sqlite # possible dependency for cargo
    sshfs
    stdenv
    strawberry
    udev
    unigine-superposition
    unixtools.ifconfig
    upower # possible dependency for vivaldi
    uv
    vivaldi
    vlc
    vulkan-loader
    vulkan-tools
    wget
    wine
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libxcb
    yt-dlp # download YouTube videos
    zlib # for stable diffusion / reliquary launcher
  ];

}
