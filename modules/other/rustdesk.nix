{ config, lib, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.rustdesk ];

  systemd.services.rustdesk = {
    description = "RustDesk unattended access";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.rustdesk}/bin/rustdesk --service";
      Restart = "always";
      RestartSec = 5;
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 21115 21116 21117 21118 21119 ];
    allowedUDPPorts = [ 21116 ];
  };
}
