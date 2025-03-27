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
  users.users.zozano = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL+JLIMMkhZty4POE+gHXrNwy11myWa0F+nVsWeyYJE3 tim@solaire.com"
    ];
  };

  services.openssh = {
    enable = true;
    settings = {
      PubkeyAuthentication = true;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      KbdInteractiveAuthentication = false;
    };
  };
}
