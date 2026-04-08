{
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.zozano.home.file."reliquary-archiver/default.nix".text = ''
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
}
