#~/.dotfiles/home-manager/modules/comfyui.nix
{ config, lib, pkgs, ... }:
{
  home.file = {
    "/home/zozano/.local/share/applications/comfyui.desktop".text = ''
      [Desktop Entry]
      Name=ComfyUI
      Exec=kitty bash -c "cd ~/test-shell && NIXPKGS_ALLOW_UNFREE=1 nix-shell --run 'cd ComfyUI && python main.py --lowvram'"
      Icon=/home/zozano/.local/share/icons/comfyui.png
      Terminal=false
      Type=Application
      Categories=Media;
    '';
  };
}
