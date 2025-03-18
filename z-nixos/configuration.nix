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
  # Automatic updating
  system.autoUpgrade = {
    enable = true;
    dates = "12:00";
  };

  security.sudo.extraRules = [
    {
      users = [ "zozano" ];
      commands = [
        {
          command = "/home/zozano/.dotfiles/home-manager/source/local/share/applications/update.sh";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];


  # Automatic cleanup
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 7d";
  nix.settings.auto-optimise-store = true;

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

  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  nixpkgs.config.permittedInsecurePackages = [
    "SDL_ttf-2.0.11"    # test removing this soon
  ];

  security.doas.enable = true;

  programs.ssh.startAgent = true;

  programs.npm.enable = true;


  networking.firewall = { 
    allowedTCPPorts = [ 8080 8000 # Open-WebUI 
    ];
    extraCommands = ''
      iptables -A nixos-fw -p tcp --source 192.168.1.0/24 --dport 8080 -j nixos-fw-accept '';
  };

  services.open-webui.enable = true;
  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

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
    ./modules/internationalisation.nix
    ./modules/openrgb.nix
    ./modules/polkit.nix
    #./modules/miniconda3.nix
    #./modules/nixvim.nix
    ./modules/nvidia.nix
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

  programs.nix-ld.enable = true;

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
    expat
    ffmpeg
    gcc
    gimp
    git
    glib
    glibc
    glibc_memusage
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
    openssl # For updater
    ostree # package for flatpak
    pango
    parted
    pavucontrol
    pcapfix
    pkg-config
    playonlinux
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
    rustdesk
    rustup
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
  ];

}
