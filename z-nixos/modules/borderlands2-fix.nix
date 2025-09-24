{ config, lib, pkgs, ... }:
{
  systemd.tmpfiles.rules = [
    "r! /usr/lib/ssl"
    "L+ /usr/lib/ssl - - - - /etc/ssl"

    "L+ /usr/lib/ssl/cert.pem - - - - /etc/ssl/certs/ca-bundle.crt"
  ];
}
