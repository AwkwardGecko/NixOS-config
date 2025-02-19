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
  hardware.xpadneo.enable = true;

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
    #./modules/nixvim.nix
    ./modules/nvidia.nix
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
    bootiso
    btrfs-progs
    docker
    docker-compose
    ffmpeg
    glibc
    git
    glibc_memusage
    gnome-disk-utility
    #btmon
    #bluez-experimental
    #bluez-alsa
    #bluez-tools
    bazel
    digikam
    libheif
    libheif.out
    lutris
    gparted
    gperftools
    qbittorrent
    gimp
    nixd # Language SP (LSP) server
    nixfmt-rfc-style # used to format styles - $ nixfmt <file>.nix
    unixtools.ifconfig
    nettools
    iproute2
    libz
    icu
    openssl # For updater
    cargo
    gcc 
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libxcb
    binutils_nogold 
    libpcap # 2025-02-19 for star rail relic scorer: Fribbels Honkai Star Rail Optimizer
    dcap 
    parted
    gtk3
    glib
    nss
    nspr
    dbus
    atk
    cups
    libdrm
    expat
    libxkbcommon
    pango
    cairo
    udev
    alsa-lib
    mesa
    libGL
    libsecret
    ostree # package for flatpak
    rpm-ostree # package for flatpak
    pxattr # allows execution of .app files
    playonlinux
    python311
    python311Packages.pip
    python311Packages.pyasyncore
    python311Packages.xattr
    python311Packages.yt-dlp
    pyenv
    rclone
    sc-controller # steam controller support
    sshfs
    smartmontools
    stdenv
    signal-desktop
    strawberry
    rustdesk
    pavucontrol
    wine
    uv
    vlc
    wget
    yt-dlp
  ];

}
