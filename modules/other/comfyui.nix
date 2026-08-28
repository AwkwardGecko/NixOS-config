{
  config,
  lib,
  pkgs,
  ...
}: {
  # services.comfyui.enable = true;
  environment.systemPackages = with pkgs; [
    comfyui
  ];

  imports = [
    ./comfyui/mods.nix
  ];

}
