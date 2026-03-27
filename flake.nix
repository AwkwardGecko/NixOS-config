{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    #nix-flatpak.url = "github:gmodena/nix-flatpak/v0.5.1"; # or whatever the latest actual tag is

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    comfyui-nix.url = "github:utensils/comfyui-nix";

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager,nix-flatpak, nixvim, comfyui-nix, stylix, ... }: {
    nixosConfigurations.z-nixos = nixpkgs.lib.nixosSystem {
	    system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        
        ./configuration.nix
        home-manager.nixosModules.home-manager
        nix-flatpak.nixosModules.nix-flatpak
        nixvim.nixosModules.nixvim
        stylix.nixosModules.stylix
        #import-tree.nixosModules.import-tree
        {
          imports = [ comfyui-nix.nixosModules.default ];
          nixpkgs.overlays = [ comfyui-nix.overlays.default ];

          nixpkgs.config.allowUnfree = true;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.zozano = import ./home.nix;
        }
      ];
    };
  };
}
