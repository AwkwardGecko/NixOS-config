{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    sshfs
    rclone
  ];
    
  etc."fuse.conf".text = ''
    user_allow_other
  '';

  fileSystems."/server" = {
    device = "z-home@192.168.1.157:/";
    fsType = "sshfs";
    options = [
      "nodev"
      "nofail"
      "allow_other"
      "IdentityFile=/root/.ssh/home-server_z-nix"
      "x-systemd.automount"
      "x-systemd.requires=network-online.target"
    ];
  };
 
  fileSystems."/data" = {
    device = "z-home@192.168.1.157:/data";
    fsType = "sshfs";
    options = [
      "nodev"
      "nofail"
      "allow_other"
      "IdentityFile=/root/.ssh/home-server_z-nix"
      "x-systemd.automount"
      "x-systemd.requires=network-online.target"
    ];
  };
}
