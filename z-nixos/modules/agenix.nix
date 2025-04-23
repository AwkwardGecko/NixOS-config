{ config, pkgs, lib, ... }:

{
   environment.systemPackages = with pkgs; [
      age
      agenix
      agenix-cli
   ];

   age.secrets.github-token = {
      file = ../../.gitignore/github-token.age;
      owner = "zozano";
   };

   systemd.services.github-token = {
      serviceConfig = {
         Environment = "GITHUB_TOKEN=${config.age.secrets.github-token.path}";
      };
   };
}
