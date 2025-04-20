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

  # boot.kernel.sysctl = {
  #   "vm.swapiness" = 50; 
  # };

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
  #services.custom-ssh-agent.enable = true;

  networking.hostName = "z-nixos";
  networking.networkmanager.enable = true;
  networking.interfaces.enp10s0.macAddress = "04:42:1A:A7:FD:1F";

  networking.nameservers = [ "1.1.1.1" "8.8.8.8"];

  networking.firewall.allowedTCPPorts = [ 
    18080 # monero
    18081 # monero
    9000 # xmrig
  ];

  networking.firewall.allowedUDPPorts = [
    9000 # xmrig
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

  programs.coolercontrol.enable = true;


  # aagl.enableNixpkgsReleaseBranchCheck = false;

  imports = [
    ./hardware-configuration.nix
    ./modules/audio.nix # audio
    ./modules/autologin.nix # 100%
    ./modules/bash.nix
    ./modules/bluetooth.nix # bluetooth
    ./modules/boot.nix # configure kernel modules
    ./modules/cachix.nix # cachix
    ./modules/chromium.nix
    #./modules/cron.nix
    ./modules/docker.nix
    ./modules/filesystem.nix
    ./modules/firefox.nix
    ./modules/fonts.nix
    ./modules/gamemode.nix
    ./modules/huge-pages.nix
    ./modules/hypr.nix
    #./modules/hyprland_instance_sig.nix
    ./modules/internationalisation.nix
    #./modules/ollama.nix
    ./modules/openrgb.nix
    ./modules/polkit.nix
    ./modules/monero.nix
    ./modules/nixvim.nix
    ./modules/nvidia.nix
    #./modules/reload-usb.nix
    ./modules/scanner.nix
    ./modules/ssh.nix
    ./modules/steam.nix
    #./modules/systemd-timers.nix
    ./modules/teamviewer.nix
    ./modules/users.nix
    ./modules/xserver.nix
    #./modules/whisperai.nix
    ./modules/wine.nix
  ];

  environment.systemPackages = with pkgs; [

    alsa-lib                    # ALSA sound library
    atk                         # Accessibility toolkit (GNOME dependencies)
    bazel                       # Google's build tool (used for TensorFlow etc.)
    #binutils_nogold             # Binutils without the gold linker
    bootiso                     # Create bootable USB drives from ISO
    brave                       # Web browser
    # btmon                    # Bluetooth monitoring/debugging
    btrfs-progs                 # Btrfs filesystem tools
    cairo                       # 2D graphics library
    cargo                       # Rust package manager
    cargo-c                     # Build C-style shared libs from Rust
    cargo-deb                   # Generate .deb packages from Rust projects
    cargo-rr                    # Run Rust programs under rr debugger
    clinfo                      # Lists OpenCL devices
    cmake
    conda                       # Python environment manager
    crane                       # Nix-native Rust build system (like crate2nix)
    cudaPackages.cudnn          # CUDA
    cudatoolkit
    cups                        # Printing system
    curl
    dbus                        # IPC system used by desktop apps
    dcap                        # Data Center Attestation Primitives (SGX stuff)
    dig                         # DNS Lookup
    #digikam                     # Photo management software
    docker                      # Container engine
    docker-compose              # Define & run multi-container apps with Docker
    evince                      # Document viewer
    evtest                      # Reads input events (debugging input devices)
    expat                       # XML parsing library
    ffmpeg                      # Video and audio processing tool
    gcc                         # GNU Compiler Collection
    gcc-unwrapped               # Unwrapped GCC (required by some projects like Stable Diffusion)
    gimp                        # Image editing software
    git                         # Version control
    glib                        # Low-level GNOME core library
    glxinfo                     # 
    #glibc_memusage              # Tracks memory usage of programs
    gnome-calculator            # Calculator app
    gnome-disk-utility          # Disk management GUI
    gparted                     # Partitioning tool
    gperftools
    gtk3                        # GNOME GUI toolkit v3
    gtkd                        # D bindings for GTK
    icu                         # Unicode support libraries
    iproute2                    # Network tools (replacement for net-tools)
    #imv                         # Image viewer
    inotify-tools               # check what is making folders
    #koboldcpp                   # Local LLM interface for KoboldAI
    jq                          #
    libGL                       # OpenGL library
    libdrm                      # Direct Rendering Manager (graphics stuff)
    libglvnd                    # OpenGL Vendor-Neutral Dispatch library (Stable Diffusion dependency)
    libheif                    # HEIF image support
    libnotify
    libpcap                     # Packet capture library (used in Fribbels Honkai Star Rail Optimizer)
    libsecret                   # Secret storage (GNOME keyring)
    libxkbcommon                # Keyboard layout handling (Wayland/X)
    lld                         # LLVM linker
    llvmPackages.bintools      # LLVM toolchain binaries (e.g., ar, nm)
    #lutris                      # Game manager (especially for Wine games)
    lsof
    lynis                       # security auditing
    mesa                        # Open-source graphics drivers
    nettools                    # Old-school network tools (ifconfig, etc.)
    nixd                        # Nix language server (LSP)
    nixfmt-rfc-style            # Nix formatter
    nodejs                      # Node.js runtime
    nomacs                      # image viewer
    nspr                        # Netscape Portable Runtime (used by Firefox, etc.)
    nss                         # Network Security Services
    nvtopPackages.nvidia        # GPU usage monitor for NVIDIA
    onlyoffice-bin              # Office suite
    openssl                     # TLS/SSL support (used by reliquary-archiver and other tools)
    pango                       # Text rendering library
    parted                      # Partitioning tool
    pavucontrol                 # PulseAudio volume control GUI
    pcapfix                     # Repairs broken .pcap files
    pkg-config                  # Finds C libraries (used by reliquary-archiver)
    protobuf                    # Google's Protocol Buffers (serialization)
    pyenv                       # Python version manager
    python3
    python311                   # Python 3.11 interpreter
    python311Packages.pyyaml
    python311Packages.numpy
    python311Packages.scipy
    python311Packages.pip       # Python 3.11 pip installer
    python311Packages.pyasyncore # Async networking module for Python 3.11
    python311Packages.setuptools
    python311Packages.wheel
    #python311Packages.torch
    python312Packages.libpcap   # Python bindings for libpcap (next-gen testing?)
    qbittorrent                 # BitTorrent client
    rclone                      # Sync with cloud storage
    rustc                       # Rust compiler
    rustup                      # Rust toolchain manager (used by reliquary-archiver)
    rustup-toolchain-install-master # Install Rust toolchains from master
    signal-desktop-bin          # Encrypted messaging desktop app
    smartmontools               # Monitor hard drive health (S.M.A.R.T.)
    sqlite                      # Embedded SQL database engine
    sshfs                       # Mount remote filesystems over SSH
    stdenv                      # Nix standard environment
    strawberry                  # Music player
    udev                        # Device manager for the Linux kernel
    # unigine-superposition       # GPU benchmarking tool
    unzip
    upower                      # Power management daemon (dependency for Vivaldi maybe)
    uv                          # Fast Python package manager
    vivaldi                     # Web browser
    vlc                         # Media player
    vulkan-loader               # Vulkan runtime loader
    vulkan-tools                # Vulkan utilities like `vulkaninfo`
    wget                        # File downloader
    wine                        # Windows compatibility layer
    xorg.libX11                 # Core X11 library
    xorg.libXcomposite          # Compositing support for X11
    xorg.libXdamage             # Damage tracking for X11
    xorg.libXext                # Misc X11 extensions
    xorg.libXfixes              # X11 fixes extension
    xorg.libXrandr              # X11 RandR extension (screen resizing)
    xorg.libxcb                 # X protocol C-language Binding
    yt-dlp                      # YouTube downloader
    zlib                        # Compression lib (used by Stable Diffusion & reliquary launcher)
  ];

}
