{
  description = "Flake File";

  inputs = {
      
      nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";

      sops-nix = {
         url = "github:Mic92/sops-nix";
         inputs.nixpkgs.follows = "nixpkgs";
      };

      home-manager = {
         url = "github:nix-community/home-manager/master";
         inputs.nixpkgs.follows = "nixpkgs";
      };

    # star-rail = {
    #   url = "path:./flakes/star-rail/";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.aagl = {
    #     url = "github:ezKEa/aagl-gtk-on-nix";
    #     inputs.nixpkgs.follows = "nixpkgs";
    #   };
    # };

      star-rail = {
         url = "path:./flakes/star-rail";
         inputs.nixpkgs.follows = "nixpkgs";
      };

      nixvim = {
         url = "github:nix-community/nixvim";
       inputs.nixpkgs.follows = "nixpkgs";
      };

      rust-overlay = {
         url = "github:oxalica/rust-overlay";
         inputs.nixpkgs.follows = "nixpkgs";
      };

      nix-comfyui = {
        url = "github:dyscorv/nix-comfyui";
        inputs.nixpkgs.follows = "nixpkgs";
      };
  };

outputs = inputs@{ self, nixpkgs, home-manager, sops-nix, nixvim, star-rail, nix-comfyui, ... }:
let
  
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = [ inputs.nix-comfyui.overlays.default ];
  };

  my-comfyui = pkgs.comfyuiPackages.comfyui.override {
    extensions = [
      pkgs.comfyuiPackages.extensions.acly-inpaint
      pkgs.comfyuiPackages.extensions.acly-tooling
      pkgs.comfyuiPackages.extensions.cubiq-ipadapter-plus
      pkgs.comfyuiPackages.extensions.fannovel16-controlnet-aux
    ];
    commandLineArgs = [
      "--preview-method" "auto"
      "--normalvram"
      "--reserve-vram" "1.5"
      "--fp16-vae"
      "--fp16-unet"
      "--fp16-text-enc"
      "--cuda-device" "0"
      "--use-pytorch-cross-attention"
    ];
  };

in {

  nixosConfigurations = {
    z-nixos = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./z-nixos/configuration.nix
        home-manager.nixosModules.home-manager
        nixvim.nixosModules.nixvim
        inputs.star-rail.defaultModule 
         
        {
          environment.systemPackages = with pkgs; [
            my-comfyui
            comfyuiPackages.krita-with-extensions
          ];

          # environment.sessionVariables = {
          # 
          # };

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
