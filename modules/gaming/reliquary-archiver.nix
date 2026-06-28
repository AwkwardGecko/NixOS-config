{
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.zozano = {
    home.file = {
      "Games/reliquary-archiver/default.nix".text = ''
        { pkgs ? import <nixpkgs> {} }:

        pkgs.mkShell {
          buildInputs = with pkgs; [
            cargo
            pkg-config
            libpcap
            wayland
            tcpdump
          ];
        }
      '';
      "Games/reliquary-archiver/build.sh" = {
        text = ''
          #!/usr/bin/env bash
          cd /home/zozano/Games/reliquary-archiver/reliquary-archiver-0.16.0
          #rm archive_output-*
          cargo build --release
          sudo setcap CAP_NET_RAW=+ep target/release/reliquary-archiver
          cargo run --release
        '';
        executable = true;
      };
      ".local/bin/reliquary-archiver.sh" = {
        text = ''
          #!/usr/bin/env bash
          cd ~/Games/reliquary-archiver && nix-shell --run ./build.sh
        '';
        executable = true;
      };
    };

    xdg.desktopEntries = {
      reliquary-archiver = {
        name = "Reliquary Archiver";
        exec = "/home/zozano/.local/bin/reliquary-archiver.sh";
        terminal = false;
        type = "Application";
        categories = ["Game"];
      };
    };
  };
}
