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
      nv = {
        PATH = "$(PATH):$(HOME)/.local/bin";
      };
      apps = [
        {
          name = "Honkai: Star Rail";
          cmd = "flatpak run moe.launcher.the-honkers-railway-launcher";
          image-path = "desktop.png";
          auto-detach = "true";
        }
      ];
    };
  };

  hardware.uinput.enable = true;
  users.users.zozano.extraGroups = [ "uinput" ];
}
