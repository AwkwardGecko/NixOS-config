{ config, pkgs, libm, ... }:
{

systemd.services.hdd-powerdown = {
  description = "Spin down HDD before shutdown";
  wantedBy = [ "shutdown.target" ];
  execStart = "/usr/bin/hdparm -y /dev/sdc";  # Replace /dev/sdc with your drive
};
}
