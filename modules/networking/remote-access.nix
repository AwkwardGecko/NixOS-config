{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    rclone
    sshfs
  ];
}
