{ config, pkgs, ... }:

{
  # storage
  systemd.tmpfiles.rules = [
    "d /srv/books 0755 webdav webdav -"
  ];
  users.users.webdav = { isSystemUser = true; group = "webdav"; };
  users.groups.webdav = {};

  # WebDAV server
  services.webdav.enable = true;
  services.webdav.settings = {
    address = "0.0.0.0";      # listen on LAN
    port = 8080;
    scope = "/srv/books";     # exported root
    modify = true;            # allow PUT/DELETE/MKCOL
    auth = true;
    users = [{
      username = "webdav";
      password = "changeme";
    }];
    # logLevel = "debug";     # enable if troubleshooting
  };

  # open firewall
  networking.firewall.allowedTCPPorts = [ 8080 ];

  # provide secrets to the unit without leaking into the Nix store
  #systemd.services.webdav.serviceConfig.EnvironmentFile = "/etc/secret/webdav.env";
}

