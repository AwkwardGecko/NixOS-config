{ config, pkgs, lib, ... }:

{
   environment.systemPackages = with pkgs; [
      age
      agenix-cli
   ];

   age.secrets.github-token = {
      file = ../../secrets/github-token.age;
      owner = "zozano";
   };

   systemd.services.github-token = {
      serviceConfig = {
         Environment = "GITHUB_TOKEN=${config.age.secrets.github-token.path}";
      };
   };
}
