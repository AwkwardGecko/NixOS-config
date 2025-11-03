{ config, pkgs, ... }:

{
  users.users.webdav = { isSystemUser = true; group = "webdav"; };
  users.groups.webdav = {};

  systemd.tmpfiles.rules = [
    "d /srv/books 0755 webdav webdav -"
    "d /var/lib/httpd 0750 root wwwrun -"
  ];

  services.httpd = {
    enable = true;
    adminAddr = "admin@example.invalid";
    modules = [ "dav" "dav_fs" "auth_basic" ];
    virtualHosts."_" = {
      listen = [{ ip = "0.0.0.0"; port = 8080; }];
      documentRoot = "/srv/books";
      extraConfig = ''
        DavLockDB /var/lib/httpd/DavLock

        <Directory "/srv/books">
          Options Indexes
          AllowOverride None
          Require all granted
          Dav On
        </Directory>

        <Location "/">
          AuthType Basic
          AuthName "WebDAV"
          AuthUserFile /var/lib/httpd/htpasswd
          Require valid-user
        </Location>
      '';
    };
  };

  networking.firewall.allowedTCPPorts = [ 8080 ];
}

