{ config, pkgs, libs, inputs, ... }:
{
  imports = [
    
    ./hardware-configuration.nix
    
    ./modules/core/audio.nix
    ./modules/core/boot.nix
    ./modules/core/filesystem.nix
    ./modules/core/hardware.nix
    ./modules/core/localisation.nix
    ./modules/core/networking.nix
    ./modules/core/nix.nix
    ./modules/core/security.nix
    ./modules/core/users.nix

    ./modules/desktop/hyprland.nix
    ./modules/desktop/hyprpanel.nix
    ./modules/desktop/rofi.nix
    ./modules/desktop/style.nix
    ./modules/desktop/stylix.nix
    ./modules/desktop/theme.nix

    ./modules/gaming/controller.nix
    ./modules/gaming/gamemode.nix
    ./modules/gaming/nvidia.nix
    ./modules/gaming/star-rail.nix
    ./modules/gaming/steam.nix
    ./modules/gaming/emulation.nix
    ./modules/gaming/lutris.nix
    ./modules/gaming/mangohud.nix

    ./modules/networking/bluetooth.nix
    ./modules/networking/ssh.nix
    ./modules/networking/syncthing.nix
    ./modules/networking/tailscale.nix
    ./modules/networking/hostname.nix
    ./modules/networking/prometheus.nix
    ./modules/networking/teamviewer.nix
    

    ./modules/shell/fish.nix
    ./modules/shell/kitty.nix
    ./modules/shell/nixvim.nix

    ./modules/media/tdarr.nix
    ./modules/dev.nix
    ./modules/shell/shell.nix




    ./modules/adwaita.nix
    ./modules/alejandra.nix
    ./modules/autologin.nix # 100%
    ./modules/bash.nix
    #./modules/beets.nix
    ./modules/bottles.nix
    ./modules/bisq.nix
    #./modules/cachix.nix # cachix
    ./modules/chromium.nix
    #.modules/comfyui.nix
    #./modules/comfyui-dependencies.nix
    ./modules/coolercontrol.nix
    #.modules/cron.nix
    ./modules/default-apps.nix
    ./modules/dolphin.nix
    ./modules/diffusion.nix
    ./modules/eigenwallet.nix
    ./modules/fclones.nix
    ./modules/firefox.nix
    ./modules/flatpak.nix
    ./modules/fonts.nix
    #./modules/ftp.nix
    ./modules/git.nix
    ./modules/git-push-dotfiles.nix
    ./modules/gpg.nix
    ./modules/haveno.nix
    ./modules/home-packages.nix
    ./modules/jellyfin-media-player.nix

    ./modules/monero.nix
    #.modules/ollama.nix
    ./modules/openrgb.nix
    ./modules/polkit.nix
    ./modules/protonmail.nix
    ./modules/protonvpn.nix
    #./modules/rustdesk.nix
    #./modules/scanner.nix
    ./modules/signal.nix
    ./modules/sshfs.nix
    ./modules/statix.nix
    #.modules/systemd-timers.nix
    ./modules/tmux.nix
    #.modules/untrunc-anthwlock.nix
    #.modules/xmrig.nix
    ./modules/wallpaper.nix
    ./modules/waybar-mpris.nix
    ./modules/whisperai.nix
    #./modules/wine.nix
  ];

  environment.systemPackages = with pkgs; [
    # bazel # Google's build tool (used for TensorFlow etc.)
    #binutils_nogold            # Binutils without the gold linker
    # brave # Web browser
    # btmon                    # Bluetooth monitoring/debugging
    #cargo # Rust package manager
    #cargo-c # Build C-style shared libs from Rust
    #cargo-deb # Generate .deb packages from Rust projects
    #cargo-rr # Run Rust programs under rr debugger
    clinfo # Lists OpenCL devices
    #digikam                     # Photo management software
    docker # Container engine
    docker-compose # Define & run multi-container apps with Docker
    ffmpeg # Video and audio processing tool
    gimp # Image editing software
    git # Version control
    #glxinfo                     #
    #glibc_memusage              # Tracks memory usage of programs
    goverlay
    #gpu-burn
    libglvnd # OpenGL Vendor-Neutral Dispatch library (Stable Diffusion dependency)
    libheif # HEIF image support
    libnotify
    mesa # Open-source graphics drivers
    openssl # TLS/SSL support (used by reliquary-archiver and other tools)
    pavucontrol # PulseAudio volume control GUI
    pkg-config # Finds C libraries (used by reliquary-archiver)
    proton-pass
    qbittorrent # BitTorrent client
    rclone # Sync with cloud storage
    #rustc                       # Rust compiler
    #rustup                      # Rust toolchain manager (used by reliquary-archiver)
    #rustup-toolchain-install-master # Install Rust toolchains from master
    sshfs # Mount remote filesystems over SSH
    strawberry # Music player
    # unigine-superposition - don't use. run .exe through steam for Vulkan support
    vlc # Media player
    vulkan-loader # Vulkan runtime loader
    vulkan-tools # Vulkan utilities like `vulkaninfo`
    wine # Windows compatibility layer
    xmrig
    yt-dlp # YouTube downloader
  ];
}
