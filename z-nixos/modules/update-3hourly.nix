##############
### POLKIT ###
##############

{
  config,
  pkgs,
  lib,
  ...
}:
{
  
systemd.services.update-nixos = {
  script = "/home/zozano/.dotfiles/scripts/update.sh";
  serviceConfig = {
    Type = "oneshot";
    User = "root";
  };
};

systemd.timers.run-script = {
  wantedBy = [ "timers.target" ];
  timerConfig = {
    OnUnitActiveSec = "3h";
    Unit = "update-nixos.service";
  };
};


}
