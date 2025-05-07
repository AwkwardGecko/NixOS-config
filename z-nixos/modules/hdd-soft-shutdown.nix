{ config, pkgs, lib, ... }:
{

systemd.services.hdd-powerdown = {
  description = "Spin down HDD before shutdown";
  wantedBy = [ "shutdown.target" ];  # This ensures the service runs during shutdown
  execStart = "/usr/bin/hdparm -y /dev/sdc";  # Replace /dev/sdc with your actual drive path
  restart = "no";  # Don't try to restart this service
};

}
