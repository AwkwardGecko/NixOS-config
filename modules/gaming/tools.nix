{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    bottles
    goverlay
    wine
    libpcap
    libwayland-dev
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

  services.sunshine = {
    enable = true;
    autoStart = false;
    openFirewall = true;
    capSysAdmin = true;
    package = pkgs.sunshine.override {
      cudaSupport = true;
      cudaPackages = pkgs.cudaPackages;
    };

    applications.env = {
      PATH = "$(PATH):$(HOME)/.local/bin";
    };

    applications.apps = [
      {
        name = "Honkai: Star Rail";
        #cmd = "sudo -u zozano setsid flatpak run --branch=stable --arch=x86_64 --command=moe.launcher.the-honkers-railway-launcher moe.launcher.the-honkers-railway-launcher";
        #cmd = "sudo -u zozano setsid HSR-skip-launcher";

        image-path = "/home/zozano/.config/sunshine/covers/igdb_394848.png";
        #exclude-global-prep-cmd = "false";
        auto-detach = "true";
      }
      {
        name = "Steam Big Picture";
        #cmd = "sudo -u zozano steam steam://open/bigpicture";
        detached = "sudo -u zozano setsid steam steam://open/bigpicture";
        # prep-cmd = [
        #   {
        #     do = "setsid steam steam://close/bigpicture";
        #     undo = "setsid steam steam://close/bigpicture";
        #     elevated = "false";
        #   }
        # ];
        image-path = "/home/zozano/.config/sunshine/covers/steam.png";
        auto-detach = "true";
      }
    ];
  };
}
