{
  config,
  lib,
  pkgs,
  ...
}:
{
  # nix.settings = {
  #   substituters = [ "https://ezkea.cachix.org" ];
  #   trusted-public-keys = [ "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" ];
  # };

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "launch-hsr" ''
      export WAYLAND_DISPLAY="''${WAYLAND_DISPLAY:-wayland-1}"
      export XDG_RUNTIME_DIR="''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
      export DISPLAY="''${DISPLAY:-:0}"
      flatpak run moe.launcher.the-honkers-railway-launcher
    '')
  ];

  home-manager.users.zozano = {
    xdg.desktopEntries."moe.launcher.the-honkers-railway-launcher" = {
      name = "Honkai: Star Rail";
      exec = "sflatpak run --branch=stable --arch=x86_64 --command=moe.launcher.the-honkers-railway-launcher moe.launcher.the-honkers-railway-launcher";
      icon = "moe.launcher.the-honkers-railway-launcher";
      comment = "Honkai: Star Rail";
      categories = [ "Game" ];
      terminal = false;
    };
  };
}
