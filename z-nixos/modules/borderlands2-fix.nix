{ config, lib, pkgs, ... }:
{
  #systemd.tmpfiles.rules = [
  #  "r! /usr/lib/ssl"
  #  "L+ /usr/lib/ssl - - - - /etc/ssl"
  #  "L+ /usr/lib/ssl/cert.pem - - - - /etc/ssl/certs/ca-bundle.crt"
  #];

  environment.systemPackages = with pkgs; [
    pkgsi686Linux.curl
    pkgsi686Linux.openssl_1_1w
  ];

  #services.resolved.enable = true;
  #environment.etc."resolv.conf".source = "/run/systemd/resolve/resolv.conf";
}
