{ lib, pkgs, ... }:

{

    services.open-webui.enable = true;
    
    services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  networking.firewall = { 
    allowedTCPPorts = [ 8080 8000 # Open-WebUI 
    ];
    extraCommands = ''
      iptables -A nixos-fw -p tcp --source 192.168.1.0/24 --dport 8080 -j nixos-fw-accept '';
  };

}
