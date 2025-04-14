{
  # to create the flake.lock file with user permissions, run:
  # $ nix flake lock

  description = "Flake File";


  inputs = {

    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
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

    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in

    {

      packages.${system} = {
        honkersFHS = pkgs.buildFHSUserEnv {
          name = "honkers-railway";
          targetPkgs = pkgs: with pkgs; [
            glibc
            gmp
            acl
            attr
            # possibly more depending on launcher logs
            # you can add others like libselinux/libcap if needed
          ];
          runScript = "${pkgs.honkers-railway-launcher}/bin/honkers-railway-launcher";
        };
      };


      nixosConfigurations = {
        z-nixos = nixpkgs.lib.nixosSystem {
          #system = "x86_64-linux";
          system = system;
          modules = [
            ./z-nixos/configuration.nix
            home-manager.nixosModules.home-manager
            nixvim.nixosModules.nixvim
            { 
              imports = [ aagl.nixosModules.default ];
              nix.settings = aagl.nixConfig;
              programs.honkers-railway-launcher.enable = true;

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.zozano = import ./home-manager/home.nix;
            }
          ]; #modules end
         
          specialArgs = {
            inherit inputs;
          };
        };
      };
    };
  } 
