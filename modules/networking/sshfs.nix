{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment = {
    systemPackages = with pkgs; [
      sshfs
      rclone
    ];
    etc."fuse.conf".text = ''
      user_allow_other
    '';
  };
}
