{
  description = "Flake File";

  inputs = {
      
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    star-rail = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nur = {
    #   url = "github:nix-community/NUR";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # nix-comfyui = {
    #   url = "github:dyscorv/nix-comfyui";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixvim, star-rail, ... }:

  let

  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = [ inputs.nix-comfyui.overlays.default ];
  };

  # my-comfyui = pkgs.comfyuiPackages.comfyui.override {
  #   extensions = with pkgs.comfyuiPackages.extensions; [
  #     acly-inpaint
  #     acly-tooling
  #     #badcafecode-execution-inversion-demo
  #     cubiq-essentials
  #     cubiq-ipadapter-plus
  #   ];
  #
  #   commandLineArgs = [
  #     "--preview-method" "auto"
  #     "--normalvram"
  #     "--reserve-vram" "1.5"
  #     "--fp16-vae"
  #     "--fp16-unet"
  #     "--fp16-text-enc"
  #     "--cuda-device" "0"
  #     "--use-pytorch-cross-attention"
  #   ];
  # };

  in {

  nixosConfigurations = {
    z-nixos = nixpkgs.lib.nixosSystem {
      
      inherit system;

      specialArgs = { inherit inputs; };


      modules = [
        ./z-nixos/configuration.nix
        home-manager.nixosModules.home-manager
        nixvim.nixosModules.nixvim
       
        {
          # environment.systemPackages = with pkgs; [
          #   my-comfyui
          #   comfyuiPackages.krita-with-extensions
          # ];

          environment.sessionVariables = {
            #STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/steam/steam/root/compatibilitytools.d";
            XDG_CURRENT_DESKTOP = "Hyprland";
            XDG_SESSION_TYPE = "wayland";
            XAUTHORITY = "\$HOME/.Xauthority";
          };

          imports = [ star-rail.nixosModules.default ];
          nix.settings = star-rail.nixConfig;
          programs.honkers-railway-launcher.enable = true;
          programs.honkers-launcher.enable = true;
          aagl.enableNixpkgsReleaseBranchCheck = false;

          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.zozano = import ./home-manager/home.nix;
        }
      ];


    };
  };
};
}
