{
  description = "Flake File";

  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    comfyui-manager = {
      url = "github:ltdrdata/ComfyUI-Manager";
      flake = false;
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
      #flake = false;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, aagl, nixvim, nix-comfyui, comfyui-manager, ... }:
    

    let
     
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
          "--lowvram"
          "--disable-smart-memory"
          "--reserve-vram"
          "1.5"
          "--fp32-vae"
          "--cuda-device"
          "0"
        ];
      };


      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          inputs.nix-comfyui.overlays.default
          (self: super: {
            comfyuiPackages = super.comfyuiPackages // {
              comfyui = super.comfyuiPackages.comfyui.overrideAttrs (old: {
                installPhase = ''
                  ${old.installPhase or ""}
                  mkdir -p $out/home/zozano/comfyui/custom_nodes
                  cp -r ${comfyui-manager}/* $out/home/zozano/comfyui/custom_nodes/
                '';
              });
            };
          })
        ];
      };
    
    in {
      nixosConfigurations = {
        z-nixos = nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
            #./flake-modules/comfyui.nix
            ./z-nixos/configuration.nix
            #./flake-modules/test/test.nix
            home-manager.nixosModules.home-manager
            nixvim.nixosModules.nixvim
            {
              imports = [ aagl.nixosModules.default ];

              nix.settings = aagl.nixConfig;
              programs.honkers-railway-launcher.enable = true;

              aagl.enableNixpkgsReleaseBranchCheck = false;

              environment.systemPackages = with pkgs; [
                my-comfyui
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

