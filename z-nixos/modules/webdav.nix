{ config, pkgs, lib, ... }:

{
  users.users.webdav = {
    isSystemUser = true;
    group = "webdav";
  };
  users.groups.webdav = {};

  # Storage
  systemd.tmpfiles.rules = [
    "d /srv/books 0755 webdav webdav -"
  ];

  services.nginx = {
    enable = true;

    # Needed for PROPFIND etc.
    additionalModules = [ pkgs.nginxModules.davExt ];

    virtualHosts."webdav.local" = {
      listen = [
        { addr = "0.0.0.0"; port = 8080; }
        # add IPv6 if you want:
        # { addr = "[::]"; port = 8080; }
      ];
      root = "/srv/books";
      basicAuthFile = "/etc/nginx/htpasswd";

      locations."/" = {
        extraConfig = ''
          client_max_body_size 2G;

          # WebDAV core
          dav_methods        PUT DELETE MKCOL COPY MOVE;
          dav_access         user:rw group:rw all:r;
          create_full_put_path on;

          # WebDAV extensions
          dav_ext_methods    PROPFIND OPTIONS;
          dav_ext_lock_zone  zone=webdav_locks:10m;

          autoindex on;  # lets you see listings in a browser
        '';
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8080 ];
}

