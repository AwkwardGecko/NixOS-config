{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    sshfs
    rclone
  ];

  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';

  fileSystems."/server" = {
    device = "z-home@192.168.1.157:/";
    fsType = "sshfs";
    options = [
      "nodev"
      "nofail"
      "allow_other"
      #"IdentityFile=/root/.ssh/home-server_z-nix"
      "IdentityFile=${config.sops.secrets."ssh/home-server-key".path}"
      "x-systemd.automount"
      "x-systemd.requires=network-online.target"
      "x-systemd.requires=tailscaled.service"
    ];
  };

  fileSystems."/data" = {
    device = "z-home@192.168.1.157:/data";
    fsType = "sshfs";
    options = [
      "nodev"
      "nofail"
      "allow_other"
      #"IdentityFile=/root/.ssh/home-server_z-nix"
      "IdentityFile=${config.sops.secrets."ssh/home-server-key".path}"
      "x-systemd.automount"
      "x-systemd.requires=network-online.target"
      "x-systemd.requires=tailscaled.service"
    ];
  };
}





