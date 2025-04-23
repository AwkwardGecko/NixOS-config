{ pkgs, aagl }:

{
  imports = [ aagl.nixosModules.default ];
  nix.settings = aagl.nixConfig;
  programs.honkers-railway-launcher.enable = true;
  aagl.enableNixpkgsReleaseBranchCheck = false;
}

