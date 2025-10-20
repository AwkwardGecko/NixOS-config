{ config, pkgs, ... }:

let
  # ── Immutable ComfyUI launcher ──────────────────────────────────────────
  runComfy = pkgs.writeShellScriptBin "run-comfy" ''
    set -euo pipefail

    ## GPU exclusive-process mode (asks for sudo once)
    if ! nvidia-smi -q | grep -q "Exclusive"; then
      echo "[run-comfy] Enabling EXCLUSIVE_PROCESS on GPU 0…"
      sudo nvidia-smi -i 0 -c EXCLUSIVE_PROCESS
    fi

    ## Environment tweaks
    export WINIT_UNIX_NO_PORTAL=1
    export __GL_FRAMEBUFFER_SRGB_CAPABLE=1
    export NIXPKGS_ALLOW_UNFREE=1
    export PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:64
    export COMFYUI_PORT=8188

    ## Update repo, then run
    workdir="$HOME/test-shell/ComfyUI"
    cd "$workdir"

    echo "[run-comfy] git pull…"
    git pull --ff-only || echo "[run-comfy] pull failed—running local copy."

    nix-shell ../shell.nix --run "
      python main.py \
        --lowvram \
        --dont-upcast-attention \
        --force-fp16 \
        --use-split-cross-attention \
        --preview-method auto \
        --reserve-vram 512 \
        --disable-smart-memory
    "
  '';
in
{
  # Keep both kitty and the script alive
  home.packages = [ runComfy pkgs.kitty ];

  # Desktop entry
  xdg.desktopEntries.comfyui = {
    name       = "ComfyUI";
    comment    = "Launch ComfyUI with CUDA low-VRAM flags";
    exec       = "${pkgs.kitty}/bin/kitty --hold -e ${runComfy}/bin/run-comfy";
    icon       = "${config.home.homeDirectory}/.local/share/icons/comfyui.png";
    terminal   = false;       # kitty is the terminal
    type       = "Application";
    categories = [ "Graphics" "Utility" ];
  };


  xdg.desktopEntries.comfyui-2 = {
    name       = "ComfyUI-2";
    comment    = "Launch ComfyUI with CUDA low-VRAM flags";
    exec       = "${pkgs.kitty}/bin/kitty --hold -e nix run github:utensils/nix-comfyui -- --open";
    icon       = "${config.home.homeDirectory}/.local/share/icons/comfyui.png";
    terminal   = false;       # kitty is the terminal
    type       = "Application";
    categories = [ "Graphics" "Utility" ];
  };
}
