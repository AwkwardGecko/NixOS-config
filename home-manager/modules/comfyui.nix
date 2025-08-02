#~/.dotfiles/home-manager/modules/comfyui.nix
{ config, lib, pkgs, ... }:

let
  comfyScript = ''
    #!/usr/bin/env bash
    set -euo pipefail

    # GPU mode
    sudo nvidia-smi -i 0 -c EXCLUSIVE_PROCESS
  
    export WINIT_UNIX_NO_PORTAL=1
    export __GL_FRAMEBUFFER_SRGB_CAPABLE=1
    export NIXPKGS_ALLOW_UNFREE=1
    export PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:64
    export COMFYUI_PORT=8188

    cd ~/test-shell/ComfyUI
    git pull origin master

    nix-shell ../shell.nix --run '
      source ../.venv/bin/activate
      pip check
      python main.py \
        --lowvram \
        --dont-upcast-attention \
        --force-fp16 \
        --use-split-cross-attention \
        --preview-method auto \
        --reserve-vram 0.5 \
        --disable-smart-memory
    '
  '';
in

{
  xdg.desktopEntries.comfyui = {
    name = "ComfyUI";
    exec = "kitty --hold -e ${config.home.homeDirectory}/.local/bin/run-comfy.sh";
    icon = "${config.home.homeDirectory}/.local/share/icons/comfyui.png";
    terminal = false;
    type = "Application";
    categories = [ "Graphics" ];
  };

  home.file.".local/bin/run-comfy.sh" = {
    executable = true;
    text = comfyScript;
  };
}
