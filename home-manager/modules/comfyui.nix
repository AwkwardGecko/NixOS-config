#~/.dotfiles/home-manager/modules/comfyui.nix
{ config, lib, pkgs, ... }:
{
  xdg.desktopEntries.comfyui = {
    name = "ComfyUI";
    exec = "kitty bash -c 'cd ~/test-shell && NIXPKGS_ALLOW_UNFREE=1 nix-shell --run \"cd ComfyUI && python main.py --lowvram\"'";
    icon = "${config.home.homeDirectory}/.local/share/icons/comfyui.png";
    terminal = false;
    type = "Application";
    categories = [ "Media" ];
  };
}
