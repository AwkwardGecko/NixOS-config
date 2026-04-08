# GPU/Firefox acceleration diagnostics
echo "=== Nvidia driver ==="
nvidia-smi --query-gpu=driver_version --format=csv,noheader 2>/dev/null || echo "nvidia-smi not found"

echo -e "\n=== VA-API ==="
vainfo 2>&1 | head -20 || echo "vainfo not found"

echo -e "\n=== Environment vars ==="
env | grep -iE '(MOZ_|LIBVA|NVD|VDPAU|GBM|__GL)' | sort

echo -e "\n=== Firefox package ==="
nix eval --raw nixpkgs#firefox.meta.name 2>/dev/null
echo
command -v firefox && firefox --version

echo -e "\n=== NixOS hardware.graphics / opengl ==="
nixos-option hardware.graphics.enable 2>/dev/null || nixos-option hardware.opengl.enable 2>/dev/null
nixos-option hardware.graphics.extraPackages 2>/dev/null | head -20 || nixos-option hardware.opengl.extraPackages 2>/dev/null | head -20

echo -e "\n=== Nvidia module config ==="
for opt in modesetting open; do
  echo -n "hardware.nvidia.$opt = "
  nixos-option hardware.nvidia.$opt 2>/dev/null | head -1 || echo "not set"
done

echo -e "\n=== about:config-relevant env ==="
# Check if wrapper sets anything
grep -r "MOZ_" ~/.dotfiles/ 2>/dev/null | grep -v '.git'
