{ config, lib, pkgs, ... }:

{
  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';
}
