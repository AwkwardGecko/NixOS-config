{ inputs, ... }:

{
  {
    nixosConfigurations = {
      z-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./z-nixos/configuration.nix
          home-manager.nixosModules.home-manager
          #stylix.nixosModules.stylix
          { 
            imports = [ aagl.nixosModules.default ];
            nix.settings = aagl.nixConfig;
            programs.honkers-railway-launcher.enable = true;

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.zozano = import ./home-manager/home.nix;
          }
        ];
      };
    };
  };
}   
