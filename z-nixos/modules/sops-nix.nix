{ pkgs, inputs, config, ... }:

{
   imports = [ inputs.sops-nix.nixosModules.sops ];

   sops.defaultSopsFile = ../../secrets/secrets.yaml;
   sops.defaultSopsFormat = "yaml";

   sops.age.keyFile = "/home/zozano/.config/sops/age/keys.txt";

   

   environment.systemPackages = with pkgs; [
      sops
   ];
}
