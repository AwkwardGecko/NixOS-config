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
  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMw7Bpl8lnXMVQF6dZPJA3qHRDgIMwcmTowzVigWWZ2E your_email@example.com"
    ];
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      KbdInteractiveAuthentication = false;
    };
  };
}
