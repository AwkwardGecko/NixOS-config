#~/.dotfiles/home-manager/modules/diffusion.nix
{ config, lib, pkgs, ... }:
{
  xdg.desktopEntries.diffusion = {
    name = "Diffusion";
    exec = ''
        ${pkgs.kitty}/bin/kitty --hold sh -c '
        sudo cryptsetup open /dev/disk/by-uuid/c5e87ce4-523f-46b9-8735-c6e7545a6d56 luks &&
        sudo mount /dev/mapper/luks /mnt/luks &&
        source /home/zozano/test-shell/.venv/bin/activate &&
        cd /home/zozano/test-shell/ComfyUI &&
        python main.py
      '
    '';
    #icon = "/home/zozano/.local/share/icons/comfyui.png";
    terminal = true;
    type = "Application";
    categories = [ "Graphics" ];
  };
}
