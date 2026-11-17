# modules/rustdesk.nix
{
  config,
  lib,
  pkgs,
  ...
}: {
  services.rustdesk-server = {
    enable = true;
    openFirewall = true; # opens 21115-21117/tcp and 21116/udp

    signal = {
      enable = true; # hbbs - rendezvous/ID server
      # Address clients will use to reach this machine.
      # Use a LAN IP for LAN-only use, or your public IP/domain
      # (with router port forwarding) for access over the internet.
      relayHosts = ["192.168.1.10"];
    };

    relay.enable = true; # hbbr - relay server
  };

  # Optional: also install the client on this machine
  environment.systemPackages = [pkgs.rustdesk-flutter];
}
