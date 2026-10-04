{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    #bottles
    #goverlay
    heroic
    wine
    snes9x

    #starship-sf64 # Star Fox 64
    # unigine-superposition - don't use. run .exe through steam for Vulkan support
    # (writeShellScriptBin "sunshine-run" ''
    #   export WAYLAND_DISPLAY="''${WAYLAND_DISPLAY:-wayland-1}"
    #   export XDG_RUNTIME_DIR="''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
    #   export DISPLAY="''${DISPLAY:-:0}"
    #   exec "$@"
    # '')
  ];

  hardware.uinput.enable = true;
  users.users.zozano.extraGroups = ["uinput"];
}
