{ config, lib, pkgs, ... }:
{
  systemd.tmpfiles.rules = [
    "L /usr/lib/ssl - - - - /etc/ssl"
  ];
}
