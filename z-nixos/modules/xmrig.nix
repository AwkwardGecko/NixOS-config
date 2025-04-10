{ config, pkgs, lib, ... }:

let
  xmrigConfig = pkgs.writeText "xmrig-config.json" (builtins.toJSON {
    api = {
      "id" = "nixos-xmrig";
    };
    autosave = true;

    cpu = {
      enabled = true;
      threads = 6;
    };

    opencl = {
      enabled = false;
    };

    cuda = {
      enabled = true;
      loader = null;  # Use system loader
    };

    pools = [
      {
        url = "pool.supportxmr.com:3333";
        user = "48rmufMfAAiHH4N8q7wzdrdvcN7AXcgwTN2oEqCrCnBafCeyFaZNjZbG6ytK4BsnpUZnLuRMAstaeSpDs3JKg4qrT3x1K2K";
        pass = "nixos";
        keepalive = true;
        tls = false;
      }
    ];
  });
in
{
  environment.systemPackages = with pkgs; [
    xmrig
  ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ nvidia-vaapi-driver ];
  };


  systemd.services.xmrig = {
    description = "XMRig Mining Service (CPU + CUDA)";
    after = [ "network.target" "nvidia-persistenced.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.xmrig}/bin/xmrig -c ${xmrigConfig}";
      Restart = "always";
      Nice = "-5";
      CPUWeight = 90;
      Environment = "LD_LIBRARY_PATH=${config.hardware.nvidia.package}/lib";
    };
  };

  powerManagement.cpuFreqGovernor = "performance";
}

