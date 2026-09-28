{
  config,
  lib,
  pkgs,
  ...
}: {
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
