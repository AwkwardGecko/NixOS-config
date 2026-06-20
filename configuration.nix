{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ./modules/core/adb.nix
    ./modules/core/audio.nix
    ./modules/core/boot.nix
    ./modules/core/boot-and-shutdown-logs.nix
    #./modules/core/filesystem.nix
    ./modules/core/hardware.nix
    ./modules/core/localisation.nix
    ./modules/core/networking.nix
    ./modules/core/nix.nix
    ./modules/core/security.nix
    ./modules/core/users.nix
    ./modules/core/scanner.nix
    ./modules/core/printer.nix

    ./modules/desktop/hyprland.nix
    ./modules/desktop/wayle.nix
    ./modules/desktop/hypridle.nix
    ./modules/desktop/rofi.nix
    ./modules/desktop/style.nix
    ./modules/desktop/stylix.nix
    ./modules/desktop/theme.nix
    ./modules/desktop/wallpaper.nix
    ./modules/desktop/portals.nix
    ./modules/desktop/wlsunset.nix
    #./modules/desktop/xfce4.nix

    ./modules/gaming/tools.nix
    ./modules/gaming/controller.nix
    ./modules/gaming/gamemode.nix
    ./modules/gaming/nvidia.nix
    ./modules/gaming/star-rail.nix
    ./modules/gaming/steam.nix
    ./modules/gaming/emulation.nix
    #./modules/gaming/lutris.nix
    ./modules/gaming/mangohud.nix
    ./modules/gaming/reliquary-archiver.nix
    ./modules/gaming/torchlight.nix

    ./modules/networking/bluetooth.nix
    ./modules/networking/ssh.nix
    ./modules/networking/syncthing.nix
    ./modules/networking/tailscale.nix
    ./modules/networking/hostname.nix
    ./modules/networking/prometheus.nix
    ./modules/networking/teamviewer.nix
    ./modules/networking/protonvpn.nix
    #./modules/networking/rclone.nix
    ./modules/networking/sshfs.nix

    ./modules/shell/tmux.nix
    ./modules/shell/fish.nix
    ./modules/shell/kitty.nix
    ./modules/shell/nixvim.nix

    ./modules/other/tdarr.nix
    ./modules/other/dev.nix
    ./modules/other/media.nix
    ./modules/other/jellyfin-inhibit.nix
    ./modules/shell/shell.nix
    ./modules/other/crypto.nix
    ./modules/other/browsers.nix
    ./modules/other/ai.nix
    ./modules/other/flatpak.nix
    ./modules/other/protonmail.nix
    ./modules/other/kde-connect.nix

    ./modules/other/signal/signal.nix
  ];
}
