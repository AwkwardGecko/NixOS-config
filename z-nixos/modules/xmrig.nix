{ pkgs, ... }:
{
  networking.firewall = {
    allowedUDPPorts = [
      9000
    ];
    allowedTCPPorts = [
      9000
    ];
  };
}

# Check ~/.dotfiles/home-manager/modules/xmrig.nix for more
