{
  # to create the flake.lock file with user permissions, run:
  # $ nix flake lock

  description = "Flake File";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    #nix-colors.url = "github:misterio77/nix-colors";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs"; 
    };

    plugin-onedark.url = "github:navarasu/onedark.nvim";
    plugin-onedark.flake = false;

    nixvim = {
      url = "github:nix-community/nixvim";
    # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
       inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    
    {
      self,
      nixpkgs,
      home-manager,
      inputs,
      aagl,
      nixvim,
      ...
    }:


    let
      #lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      system = "x86_64-linux";
     in
    {
      nixosConfigurations = {
        z-nixos = nixpkgs.lib.nixosSystem { #newedit
          system = "x86_64-linux";
          #extraSpecialArgs = { inherit inputs; };
          modules = [
            ./sys/configuration.nix
            z-home.inputs.home-manager.nixosModules.z-nixos
            { 
              imports = [ aagl.nixosModules.default ];
              nix.settings = aagl.nixConfig;
              programs.honkers-railway-launcher.enable = true;
            }
          ];
        };
      };

      # homeConfigurations = {
      #   z-home = home-manager.lib.homeManagerConfiguration {
      #     inherit pkgs;
      #     extraSpecialArgs = {
      #       inherit inputs;
      #     };
      #     modules = [ ./home-manager/home.nix ];
      #   };
      # };
    };
}
