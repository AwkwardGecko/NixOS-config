#################
### AUTOSTART ###
#################

{
  config,
  pkgs,
  lib,
  ...
}:
{
  systemd.user.services.zozano = {
    description = "mount-server";
    serviceConfig.PassEnvironment = "DISPLAY";
    script = ''
      bash /home/zozano/.local/share/applications/mount-server.sh
      '';
    wantedBy = [ "multi-user.target" ]; # starts after login
};
