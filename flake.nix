{
  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    comfyui-nix.url = "github:utensils/comfyui-nix";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixvim, comfyui-nix, ... }: {
    nixosConfigurations.z-nixos = nixpkgs.lib.nixosSystem {
	    system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        
        ./configuration.nix
        home-manager.nixosModules.home-manager
        nixvim.nixosModules.nixvim
        {
          nixpkgs.overlays = [ comfyui-nix.overlays.default ];
          environment.systemPackages = [ pkgs.comfy-ui ];

          nixpkgs.config.allowUnfree = true;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.zozano = import ./home.nix;
        }
      ];
    };
  };
}
