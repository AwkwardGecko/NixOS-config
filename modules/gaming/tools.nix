{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bottles
    goverlay
    wine
    # wine-wayland
    # wine-staging
    # winetricks
    # unigine-superposition - don't use. run .exe through steam for Vulkan support
  ];

  services.sunshine = {
    enable = true;
    autoStart = true;
    openFirewall = true;
    capSysAdmin = true;
    package = pkgs.sunshine.override {
      cudaSupport = true;
      cudaPackages = pkgs.cudaPackages;
    };

    applications = {
      env = {
        PATH = "$(PATH):$(HOME)/.local/bin";
        WAYLAND_DISPLAY = "wayland-1";
        XDG_RUNTIME_DIR = "/run/user/1000";
        DISPLAY = ":0";
      };
      apps = [
        {
          name = "Honkai: Star Rail";
          cmd = "launch-hsr";
          image-path = "/home/zozano/.config/sunshine/covers/igdb_394848.png";
          auto-detach = "true";
        }
        {
          name = "Steam Big Picture";
          cmd = "steam steam://open/bigpicture";
          image-path = "/home/zozano/.config/sunshine/covers/steam.png";
          auto-detach = "true";
        }
      ];
    };
  };

  hardware.uinput.enable = true;
  users.users.zozano.extraGroups = [ "uinput" ];
}
