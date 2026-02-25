{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    comfyui-nix.url = "github:utensils/comfyui-nix";

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    import-tree = {
      url = "github:vic/import-tree";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixvim, comfyui-nix, stylix, import-tree, ... }: {
    nixosConfigurations.z-nixos = nixpkgs.lib.nixosSystem {
	    system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        
        ./configuration.nix
        home-manager.nixosModules.home-manager
        nixvim.nixosModules.nixvim
        stylix.nixosModules.stylix
        #import-tree.nixosModules.import-tree
        {
          # imports = [ comfyui-nix.nixosModules.default ];
          # nixpkgs.overlays = [ comfyui-nix.overlays.default ];
          # services.comfyui = {
          #   enable = true;
          #   cuda = true;
          #   enableManager = true;
          #   port = 8188;
          #   listenAddress = "127.0.0.1";
          #   dataDir = "/var/lib/comfyui";
          #   openFirewall = false;
          #   #extraArgs = [ "--lowvram" ];
          #   # environment = {};
          # };

          nixpkgs.config.allowUnfree = true;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.zozano = import ./home.nix;
        }
      ];
    };
  };
}
