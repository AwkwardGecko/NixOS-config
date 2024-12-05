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
      bash sshfs z-home@192.168.1.157:/ /server -oport=421
      '';
    wantedBy = [ "multi-user.target" ]; # starts after login
  };
}
