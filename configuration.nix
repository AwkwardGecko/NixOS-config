#~/.dotfiles/z-nixos/configuration.nix
{
  config,
  pkgs,
  libs,
  inputs,
  ...
}:
{

  # limit rebuild speed
  nix.settings.max-jobs = 2;
  nix.settings.cores = 6;

  imports = [
    ./hardware-configuration.nix
    ./sys-modules/adwaita.nix
    ./sys-modules/alejandra.nix
    ./sys-modules/android.nix
    ./sys-modules/audio.nix # audio
    ./sys-modules/autologin.nix # 100%
    ./sys-modules/bash.nix
    ./sys-modules/bluetooth.nix # bluetooth
    ./sys-modules/boot.nix # configure kernel modules
    #./sys-modules/#borderlands2-fix.nix
    ./sys-modules/bottles.nix
    ./sys-modules/bisq.nix
    ./sys-modules/cachix.nix # cachix
    ./sys-modules/chromium.nix
    #./sys-modules/#comfyui.nix
    ./sys-modules/controller.nix
    ./sys-modules/coolercontrol.nix
    #./sys-modules/#cron.nix
    #./sys-modules/docker.nix
    ./sys-modules/dolphin.nix
    ./sys-modules/eigenwallet.nix
    ./sys-modules/fclones.nix
    ./sys-modules/filesystem.nix
    ./sys-modules/firefox.nix
    ./sys-modules/flatpak.nix
    ./sys-modules/fonts.nix
    ./sys-modules/ftp.nix
    ./sys-modules/gamemode.nix
    ./sys-modules/git.nix
    ./sys-modules/git-push-dotfiles.nix
    ./sys-modules/haveno.nix
    ./sys-modules/hostname.nix
    ./sys-modules/hdd-soft-shutdown.nix
    ./sys-modules/huge-pages.nix
    ./sys-modules/hypr.nix
    ./sys-modules/localisation.nix
    #./sys-modules/#lutris.nix
    #./sys-modules/#ollama.nix
    ./sys-modules/openrgb.nix
    ./sys-modules/polkit.nix
    ./sys-modules/prometheus.nix
    ./sys-modules/protonmail.nix
    ./sys-modules/protonvpn.nix
    ./sys-modules/monero.nix
    ./sys-modules/nixvim.nix
    ./sys-modules/nvidia.nix
    #./sys-modules/#reload-usb.nix
    ./sys-modules/scanner.nix
    ./sys-modules/security.nix
    ./sys-modules/shadps4.nix
    ./sys-modules/signal.nix
    ./sys-modules/ssh.nix
    ./sys-modules/sshfs.nix
    #./sys-modules/star-rail.nix
    ./sys-modules/statix.nix
    ./sys-modules/steam.nix
    ./sys-modules/syncthing.nix
    #./sys-modules/#systemd-timers.nix
    ./sys-modules/tailscale.nix
    ./sys-modules/tdarr.nix
    ./sys-modules/teamviewer.nix
    #./sys-modules/#untrunc-anthwlock.nix
    ./sys-modules/users.nix
    ./sys-modules/xdg-desktop-portal.nix
    #./sys-modules/#xmrig.nix
    #./sys-modules/#xserver.nix
    ./sys-modules/waybar-mpris.nix
    #./sys-modules/# whisperai.nix
    #./sys-modules/# webdav.nix
    ./sys-modules/wine.nix
  ];

  security.sudo = {
    extraRules = [
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

    extraConfig = ''
      Defaults timestamp_timeout=-1
    '';
  };

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

  networking.hostName = "z-nixos";
  networking.networkmanager.enable = true;
  networking.interfaces.enp10s0.macAddress = "04:42:1A:A7:FD:1F";

  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];

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

  environment.systemPackages = with pkgs; [
    age # generate keypair
    alejandra # format nix files
    alsa-lib # ALSA sound library
    atk # Accessibility toolkit (GNOME dependencies)
    bazel # Google's build tool (used for TensorFlow etc.)
    bc
    #binutils_nogold            # Binutils without the gold linker
    bootiso # Create bootable USB drives from ISO
    brave # Web browser
    # btmon                    # Bluetooth monitoring/debugging
    btop
    btrfs-progs # Btrfs filesystem tools
    cairo # 2D graphics library
    cargo # Rust package manager
    cargo-c # Build C-style shared libs from Rust
    cargo-deb # Generate .deb packages from Rust projects
    cargo-rr # Run Rust programs under rr debugger
    clinfo # Lists OpenCL devices
    cmake
    compose2nix
    conda # Python environment manager
    crane # Nix-native Rust build system (like crate2nix)
    cups # Printing system
    curl
    dbus # IPC system used by desktop apps
    dcap # Data Center Attestation Primitives (SGX stuff)
    dig # DNS Lookup
    #digikam                     # Photo management software
    docker # Container engine
    docker-compose # Define & run multi-container apps with Docker
    evince # Document viewer
    evtest # Reads input events (debugging input devices)
    expat # XML parsing library
    ffmpeg # Video and audio processing tool
    hdparm
    gawk
    gcc # GNU Compiler Collection
    gcc-unwrapped # Unwrapped GCC (required by some projects like Stable Diffusion)
    gimp # Image editing software
    git # Version control
    glib # Low-level GNOME core library
    #glxinfo                     #
    #glibc_memusage              # Tracks memory usage of programs
    gedit
    
    gnome-calculator # Calculator app
    gnome-disk-utility # Disk management GUI
    goverlay
    gparted # Partitioning tool
    gperftools
    gtk3 # GNOME GUI toolkit v3
    gtkd # D bindings for GTK
    icu # Unicode support libraries
    iproute2 # Network tools (replacement for net-tools)
    #imv                         # Image viewer
    inotify-tools # check what is making folders
    #koboldcpp                   # Local LLM interface for KoboldAI
    jq
    libcap # test
    libGL # OpenGL library
    libglvnd
    libdrm # Direct Rendering Manager (graphics stuff)
    libglvnd # OpenGL Vendor-Neutral Dispatch library (Stable Diffusion dependency)
    libheif # HEIF image support
    libnotify
    #libpcap                     # Packet capture library (used in Fribbels Honkai Star Rail Optimizer)
    libsecret # Secret storage (GNOME keyring)
    libxkbcommon # Keyboard layout handling (Wayland/X)
    libz
    lld # LLVM linker
    llvmPackages.bintools # LLVM toolchain binaries (e.g., ar, nm)
    #lutris                      # Game manager (especially for Wine games)
    lsof
    lynis # security auditing
    mesa # Open-source graphics drivers
    nettools # Old-school network tools (ifconfig, etc.)
    nixd # Nix language server (LSP)
    nixfmt
    nodejs # Node.js runtime
    nomacs # image viewer
    nspr # Netscape Portable Runtime (used by Firefox, etc.)
    nss # Network Security Services
    onlyoffice-desktopeditors # Office suite
    opencv
    openssl # TLS/SSL support (used by reliquary-archiver and other tools)
    pango # Text rendering library
    parted # Partitioning tool
    pavucontrol # PulseAudio volume control GUI
    pcapfix # Repairs broken .pcap files
    pciutils # testing PCI links
    pkg-config # Finds C libraries (used by reliquary-archiver)
    protobuf # Google's Protocol Buffers (serialization)
    proton-pass
    pyenv # Python version manager
    python3
    python311 # Python 3.11 interpreter
    python311Packages.pyyaml
    python312Packages.numpy
    python311Packages.scipy
    python311Packages.pip # Python 3.11 pip installer
    python311Packages.pyasyncore # Async networking module for Python 3.11
    python311Packages.setuptools
    python311Packages.wheel
    #python311Packages.torch
    # python312Packages.libpcap   # Python bindings for libpcap (next-gen testing?)
    python312Packages.opencv-python
    qbittorrent # BitTorrent client
    rclone # Sync with cloud storage
    #rustc                       # Rust compiler
    #rustup                      # Rust toolchain manager (used by reliquary-archiver)
    #rustup-toolchain-install-master # Install Rust toolchains from master
    smartmontools # Monitor hard drive health (S.M.A.R.T.)
    sqlite # Embedded SQL database engine
    sshfs # Mount remote filesystems over SSH
    stdenv # Nix standard environment
    strawberry # Music player
    usbutils
    udev # Device manager for the Linux kernel
    # unigine-superposition       # GPU benchmarking tool
    unzip
    upower # Power management daemon (dependency for Vivaldi maybe)
    uv # Fast Python package manager
    vlc # Media player
    vulkan-loader # Vulkan runtime loader
    vulkan-tools # Vulkan utilities like `vulkaninfo`
    wl-clipboard # clipboard support for wayland
    wget # File downloader
    wine # Windows compatibility layer
    xmrig
    xorg.libX11 # Core X11 library
    xorg.libXcomposite # Compositing support for X11
    xorg.libXdamage # Damage tracking for X11
    xorg.libXext # Misc X11 extensions
    xorg.libXfixes # X11 fixes extension
    xorg.libXrandr # X11 RandR extension (screen resizing)
    xorg.libxcb # X protocol C-language Binding
    yt-dlp # YouTube downloader
    zlib # Compression lib (used by Stable Diffusion & reliquary launcher)
  ];
}
