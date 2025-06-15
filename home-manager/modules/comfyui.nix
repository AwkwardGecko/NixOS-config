#~/.dotfiles/home-manager/modules/comfyui.nix
{ config, lib, pkgs, ... }:
{
  {
    home.file = {
      ".local/share/applications".text = ''
        [Desktop Entry]
        Name=ComfyUI
        Exec=kitty bash -c 'cd /home/zozano/comfyui && comfyui & sleep 5 && firefox -P Diffusion http://127.0.0.1:8188'
        Icon=jellyfin-media-player
        Terminal=false
        Type=Application
        Categories=Media;
      '';
    };
  };
}
