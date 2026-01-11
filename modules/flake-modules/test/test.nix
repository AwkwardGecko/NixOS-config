{
  inputs.nix-comfyui.url = "github:dyscorv/nix-comfyui";
  inputs.nix-comfyui.inputs.nixpkgs.follows = "nixpkgs";

  outputs =
    {
      self,
      nix-comfyui,
      nixpkgs,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ nix-comfyui.overlays.default ];
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          # Check available attributes from the nix-comfyui flake
          nix-comfyui
        ];
      };
    };
}
