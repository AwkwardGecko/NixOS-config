{ config, pkgs, lib, ... }:

{
   imports = [ ./secrets.nix ];
   age.secrets.my-secret = {
      file = ./secrets/my-secret.age;
   };

   systemd.services.my-service = {
      serviceConfig.EnvironmentFile = config.age.secrets.my-secret.path;
   };



}
