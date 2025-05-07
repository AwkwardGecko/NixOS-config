{ config, pkgs, ... }:

{
  systemd.services.hdd-powerdown = {
    description = "Spin down HDD before shutdown";
    wantedBy = [ "shutdown.target" ];
    serviceConfig.ExecStart = "${pkgs.hdparm}/bin/hdparm -y /dev/sdc";  # Ensure this points to the correct drive
    restart = "no";
  };
}

