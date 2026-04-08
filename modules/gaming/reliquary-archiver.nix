{
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.zozano.home.file = {
    "reliquary-archiver/default.nix".text = ''
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
    "reliquary-archiver/build.sh".text = ''
      #!/usr/bin/env bash
      cd reliquary-archiver-*
      cargo build --release
      sudo setcap CAP_NET_RAW=+ep target/release/reliquary-archiver
      cargo run
    '';
  };
}
