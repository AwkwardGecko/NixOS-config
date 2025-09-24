{ config, lib, pkgs, ... }:
{
  systemd.tmpfiles.rules = [
    "r! /usr/lib/ssl"
    "L+ /usr/lib/ssl - - - - /etc/ssl"
    "L+ /usr/lib/ssl/cert.pem - - - - /etc/ssl/certs/ca-bundle.crt"
  ];

  services.resolved.enable = true;
  #environment.etc."resolv.conf".source = "/run/systemd/resolve/resolv.conf";
}
