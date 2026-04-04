{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.ssh.startAgent = true;

  services.openssh = {
    enable = true;
    settings = {
      PubkeyAuthentication = true;
      PasswordAuthentication = true;
      PermitRootLogin = "no";
      KbdInteractiveAuthentication = false;
    };
  };
}
