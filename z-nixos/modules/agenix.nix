{ config, pkgs, lib, ... }:

{
   environment.systemPackages = with pkgs; [
      age
      agenix-cli
   ];

   # age.secrets.github-token = {
   #    file = ../../secrets/github-token.age;
   #    recipients = [
   #       "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGmBtbRHIiny56UVPCWE3icyyHZLZdb2U2Y3eDWUbtXE zozano@z-nixos"
   #    ];
   # };

   # systemd.services.my-service = {
   #    serviceConfig.EnvironmentFile = config.age.secrets.github-token.path;
   # };
}
