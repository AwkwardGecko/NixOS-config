{ config, pkgs, ... }:

{
  users.users.webdav = {
    isSystemUser = true;
    group = "webdav";
  };
  users.groups.webdav = {};

  systemd.tmpfiles.rules = [
    "d /srv/books 0755 webdav webdav -"
  ];

  environment.systemPackages = [ pkgs.webdav-server-rs ];

  systemd.services.webdav = {
    description = "WebDAV";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      User = "webdav";
      Group = "webdav";
      Restart = "on-failure";
      EnvironmentFile = "/etc/secret/webdav.env";
      ExecStart = ''
        ${pkgs.webdav-server-rs}/bin/webdav-server-rs \
          --host 0.0.0.0 \
          --port 8080 \
          --dir /srv/books \
          --auth-user webdav \
          --auth-pass "$WEBDAV_PASSWORD"
      '';
      ProtectSystem = "full";
      ProtectHome = true;
      PrivateTmp = true;
      NoNewPrivileges = true;
    };
  };

  networking.firewall.allowedTCPPorts = [ 8080 ];
}

