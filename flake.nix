{
  # to create the flake.lock file with user permissions, run:
  # $ nix flake lock

  description = "Flake File";

  inputs = {

    nixpkgs.url = "github:Nixos/nixpkgs?ref=nixos-unstable";

    nix-colors.url = "github:misterio77/nix-colors";

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
    
    inputs@{
      self,
      nixpkgs,
      home-manager,
      aagl,
      nixvim,
      ...
    }:



    {
      nixosConfigurations = {
        z-nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./z-nixos/configuration.nix
            home-manager.nixosModules.home-manager
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
    
