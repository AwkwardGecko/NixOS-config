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
    xdg.desktopEntries."moe.launcher.the-honkers-railway-launcher2" = {
      name = "Honkai: Star Rail";
      #exec = "flatpak run --branch=stable --arch=x86_64 --command=moe.launcher.the-honkers-railway-launcher moe.launcher.the-honkers-railway-launcher";
      exec = "HSR-skip-launcher"; 
      icon = "moe.launcher.the-honkers-railway-launcher";
      comment = "Honkai: Star Rail";
      categories = [ "Game" ];
      terminal = false;
    };

    home.packages = [
      (pkgs.writeShellScriptBin "HSR-skip-launcher" ''
        BASE="$HOME/.var/app/moe.launcher.the-honkers-railway-launcher/data/honkers-railway-launcher"

        export WINEPREFIX="$BASE/prefix"
        export WINEFSYNC=1
        export WINE_FULLSCREEN_FSR=1
        export WINE_FULLSCREEN_FSR_STRENGTH=2

        WINE="$BASE/runners/spritz-wine-tkg-staging-wow64-10.15-8/bin/wine"
        JADEITE="$BASE/patch/jadeite.exe"
        GAME="$BASE/HSR/StarRail.exe"

        steam-run "$WINE" "$JADEITE" "$GAME"
      '')
    ];
  };
}
