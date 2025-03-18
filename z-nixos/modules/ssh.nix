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
  users.users.zozano.openssh.authorizedKeys.keyFiles = [
    /home/zozano/.ssh
  ];


}
