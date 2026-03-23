#~/.dotfiles/z-nixos/configuration.nix
{
  config,
  pkgs,
  libs,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/adwaita.nix
    ./modules/alejandra.nix
    ./modules/android.nix
    ./modules/audio.nix # audio
    ./modules/autologin.nix # 100%
    ./modules/bash.nix
    ./modules/bluetooth.nix # bluetooth
    ./modules/boot.nix # configure kernel modules
    #.modules/#borderlands2-fix.nix
    ./modules/bottles.nix
    ./modules/bisq.nix
    ./modules/cachix.nix # cachix
    ./modules/chromium.nix
    #.modules/#comfyui.nix
    #./modules/comfyui-dependencies.nix
    ./modules/controller.nix
    ./modules/coolercontrol.nix
    #.modules/#cron.nix
    #.modules/docker.nix
    ./modules/dolphin.nix
    ./modules/eigenwallet.nix
    ./modules/fclones.nix
    ./modules/filesystem.nix
    ./modules/firefox.nix
    ./modules/flatpak.nix
    ./modules/fonts.nix
    ./modules/ftp.nix
    ./modules/gamemode.nix
    ./modules/git-system.nix
    ./modules/git-push-dotfiles.nix
    ./modules/haveno.nix
    ./modules/hostname.nix
    ./modules/hdd-soft-shutdown.nix
    ./modules/huge-pages.nix
    ./modules/hyprland-system.nix
    ./modules/jellyfin-media-player.nix
    ./modules/localisation.nix
    #.modules/#lutris.nix
    ./modules/nintendo64.nix
    #.modules/#ollama.nix
    ./modules/openrgb.nix
    ./modules/polkit.nix
    ./modules/prometheus.nix
    ./modules/protonmail.nix
    ./modules/protonvpn.nix
    ./modules/monero.nix
    ./modules/nixvim.nix
    ./modules/nvidia.nix
    #.-modules/#reload-usb.nix
    #./modules/rustdesk.nix
    #./modules/scanner.nix
    ./modules/security.nix
    ./modules/shadps4.nix
    ./modules/signal.nix
    ./modules/ssh.nix
    ./modules/sshfs.nix
    #.modules/star-rail.nix
    ./modules/statix.nix
    ./modules/steam.nix
    ./modules/stylix.nix
    ./modules/syncthing.nix
    #.modules/#systemd-timers.nix
    ./modules/tailscale.nix
    ./modules/tdarr.nix
    ./modules/teamviewer.nix
    #.modules/#untrunc-anthwlock.nix
    ./modules/users.nix
    ./modules/xdg-desktop-portal.nix
    #.modules/#xmrig.nix
    #.modules/#xserver.nix
    ./modules/waybar-mpris.nix
    ./modules/whisperai.nix
    #.modules/# webdav.nix
    #./modules/wine.nix
  ];


  # Automatic cleanup
  nix = {
    gc = { # garbage collection
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
    audacity
    alejandra # format nix files
    alsa-lib # ALSA sound library
    atk # Accessibility toolkit (GNOME dependencies)
    # bazel # Google's build tool (used for TensorFlow etc.)
    bc
    #binutils_nogold            # Binutils without the gold linker
    bootiso # Create bootable USB drives from ISO
    # brave # Web browser
    # btmon                    # Bluetooth monitoring/debugging
    btop
    btrfs-progs # Btrfs filesystem tools
    cairo # 2D graphics library
    #cargo # Rust package manager
    #cargo-c # Build C-style shared libs from Rust
    #cargo-deb # Generate .deb packages from Rust projects
    #cargo-rr # Run Rust programs under rr debugger
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
    #gpu-burn
    #gtk3 # GNOME GUI toolkit v3
    #gtkd # D bindings for GTK
    icu # Unicode support libraries
    iproute2 # Network tools (replacement for net-tools)
    inotify-tools # check what is making folders
    jq
    libX11 # Core X11 library
    libXcomposite # Compositing support for X11
    libXdamage # Damage tracking for X11
    libXext # Misc X11 extensions
    libXfixes # X11 fixes extension
    libXrandr # X11 RandR extension (screen resizing)
    libxcb # X protocol C-language Binding
    libcap # test
    libGL # OpenGL library
    libglvnd
    libdrm # Direct Rendering Manager (graphics stuff)
    libglvnd # OpenGL Vendor-Neutral Dispatch library (Stable Diffusion dependency)
    libheif # HEIF image support
    libnotify
    libsecret # Secret storage (GNOME keyring)
    libxkbcommon # Keyboard layout handling (Wayland/X)
    libz
    lld # LLVM linker
    llvmPackages.bintools # LLVM toolchain binaries (e.g., ar, nm)
    lsof
    lynis # security auditing
    mesa # Open-source graphics drivers
    nettools # Old-school network tools (ifconfig, etc.)
    nixd # Nix language server (LSP)
    nix-prefetch-github
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
    python312Packages.numpy
    python312Packages.opencv-python
    qbittorrent # BitTorrent client
    qt5.qtwayland
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
    # unigine-superposition - don't use. run .exe through steam for Vulkan support
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

    yt-dlp # YouTube downloader
    zlib # Compression lib (used by Stable Diffusion & reliquary launcher)
  ];
}
