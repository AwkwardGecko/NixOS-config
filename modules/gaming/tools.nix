{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bottles
    goverlay
    wine
    # unigine-superposition - don't use. run .exe through steam for Vulkan support
    # (writeShellScriptBin "sunshine-run" ''
    #   export WAYLAND_DISPLAY="''${WAYLAND_DISPLAY:-wayland-1}"
    #   export XDG_RUNTIME_DIR="''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
    #   export DISPLAY="''${DISPLAY:-:0}"
    #   exec "$@"
    # '')
  ];

  hardware.uinput.enable = true;
  users.users.zozano.extraGroups = [ "uinput" ];

  services.sunshine = {
    enable = true;
    autoStart = true;
    openFirewall = true;
    capSysAdmin = true;
    package = pkgs.sunshine.override {
      cudaSupport = true;
      cudaPackages = pkgs.cudaPackages;
    };
      
    # applications.apps = [
    #   {
    #     name = "Honkai: Star Rail";
    #     #cmd = "launch-hsr";
    #     #cmd = "flatpak run --branch=stable --arch=x86_64 --command=moe.launcher.the-honkers-railway-launcher moe.launcher.the-honkers-railway-launcher";
    #     cmd = "/run/current-system/sw/bin/sunshine-run HSR-skip-launcher";
    #     image-path = "/home/zozano/.config/sunshine/covers/igdb_394848.png";
    #     auto-detach = "true";
    #   }
    #   {
    #     name = "Steam Big Picture";
    #     cmd = "/run/current-system/sw/bin/sunshine-run steam steam://open/bigpicture";
    #     image-path = "/home/zozano/.config/sunshine/covers/steam.png";
    #     auto-detach = "true";
    #   }
    # ];
  };
}
