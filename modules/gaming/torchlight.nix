# ~/.dotfiles/z-nixos/modules/torchlight-saves.nix
{
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.zozano = {
    xdg.desktopEntries = {
      torchlight-save = {
        name = "Torchlight Save";
        exec = "/home/zozano/.dotfiles/scripts/torchlight-save.sh";
        terminal = false;
        type = "Application";
        categories = ["Game"];
      };
      torchlight-load = {
        name = "Torchlight Load";
        exec = "/home/zozano/.dotfiles/scripts/torchlight-load.sh";
        terminal = false;
        type = "Application";
        categories = ["Game"];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    (lib.hiPrio (python3.withPackages (ps: [ ps.pygobject3 ])))
    glib
    gdk-pixbuf
    gobject-introspection
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    pipewire
  ];

  environment.pathsToLink = [
    "/lib/girepository-1.0"
    "/lib/gstreamer-1.0"
  ];

  environment.profileRelativeSessionVariables = {
    GI_TYPELIB_PATH = [ "/lib/girepository-1.0" ];
    GST_PLUGIN_SYSTEM_PATH_1_0 = [ "/lib/gstreamer-1.0" ];
  };

  programs.ydotool.enable = true;
  users.users.zozano.extraGroups = [ "ydotool" ];
}
