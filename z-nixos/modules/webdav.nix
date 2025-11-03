{ config, pkgs, ... }:

{
  users.users.webdav = {
    isSystemUser = true;
    createHome = false;
    group = "webdav";
    #shell = pkgs.nologin;
    password = "changeme"; # optional if using htpasswd below
  };

  users.groups.webdav = {};

  # Directory to serve
  systemd.tmpfiles.rules = [
    "d /srv/books 0755 webdav webdav -"
  ];

  # Install server binary
  environment.systemPackages = [ pkgs.webdav-server-rs ];

  # Systemd service
  systemd.services.webdav = {
    description = "Simple WebDAV Server";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];

    serviceConfig = {
      Restart = "on-failure";
      ExecStart = "${pkgs.webdav-server-rs}/bin/webdav-server-rs \
        --host 0.0.0.0 \
        --port 8081 \
        --dir /srv/books \
        --auth-user webdav \
        --auth-pass changeme";
      User = "webdav";
      Group = "webdav";
    };
  };

  # Firewall
  networking.firewall.allowedTCPPorts = [ 8080 ];
}

