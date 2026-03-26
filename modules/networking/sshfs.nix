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
    ];
    etc."fuse.conf".text = ''
      user_allow_other
    '';
  };
}
