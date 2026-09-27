{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    rclone
  ];

  system.fsPackages = [pkgs.sshfs];

  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';

  fileSystems."/server" = {
    device = "z-home@192.168.1.169:/";
    fsType = "sshfs";
    options = [
      "nodev"
      "nofail"
      "_netdev"
      "reconnect"
      "allow_other"
      "ServerAliveInterval=15"
      "IdentityFile=/root/.ssh/home-server_z-nix"
      #"IdentityFile=${config.sops.secrets."ssh/home-server-key".path}"
      "x-systemd.automount"
      #"x-systemd.requires=network-online.target"
      #"x-systemd.requires=tailscaled.service"
    ];
  };

  fileSystems."/data" = {
    device = "z-home@192.168.1.169:/data";
    fsType = "sshfs";
    options = [
      "nodev"
      "nofail"
      "_netdev"
      "reconnect"
      "allow_other"
      "ServerAliveInterval=15"
      "IdentityFile=/root/.ssh/home-server_z-nix"
      #"IdentityFile=${config.sops.secrets."ssh/home-server-key".path}"
      "x-systemd.automount"
      #"x-systemd.requires=network-online.target"
      #"x-systemd.requires=tailscaled.service"
    ];
  };
}
