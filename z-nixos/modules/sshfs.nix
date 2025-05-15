{ config, lib, pkgs, ... }:

{
  programs.sshfs.enable = true;

  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';

}
