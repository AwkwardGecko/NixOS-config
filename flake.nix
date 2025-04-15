{
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

    nix-comfyui = {
      url = "github:dyscorv/nix-comfyui";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, aagl, nixvim, nix-comfyui, ... }:
    let
     
      myRuntimeDir = "/home/zozano/comfyui-runtime";

        comfyWrapper = pkgs.writeShellScriptBin "comfyui" ''
          mkdir -p "${myRuntimeDir}"
          cd "${myRuntimeDir}"
          exec ${my-comfyui}/bin/comfyui "$@"
        '';

      my-comfyui = pkgs.comfyuiPackages.comfyui.override {
        extensions = [
          pkgs.comfyuiPackages.extensions.acly-inpaint
          pkgs.comfyuiPackages.extensions.acly-tooling
          pkgs.comfyuiPackages.extensions.cubiq-ipadapter-plus
          pkgs.comfyuiPackages.extensions.fannovel16-controlnet-aux
        ];

        commandLineArgs = [
          "--preview-method"
          "auto"
        ];
      };


      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ inputs.nix-comfyui.overlays.default ];
      };
    in {
      nixosConfigurations = {
        z-nixos = nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
            ./z-nixos/configuration.nix
            home-manager.nixosModules.home-manager
            nixvim.nixosModules.nixvim
            {
              imports = [ aagl.nixosModules.default ];

              nix.settings = aagl.nixConfig;
              programs.honkers-railway-launcher.enable = true;

              environment.systemPackages = with pkgs; [
                my-comfyui
                comfyWrapper
                comfyuiPackages.krita-with-extensions
              ];

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.zozano = import ./home-manager/home.nix;
            }
          ];

          specialArgs = {
            inherit inputs;
          };
        };
      };
    };
}

