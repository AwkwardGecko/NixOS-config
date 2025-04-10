{ config, pkgs, ... }:

{
  services.xmrig = {
    enable = true;
    settings = {

      autosave = true;
      autosave-interval = 300;
      cpu = true;
      opencl = false;
      cuda = false;
      
      # CPU settings
      cpu-priority = 5;
      cpu-usage = 75;
      threads = 6;


      # RandomX optimizations
      randomx = {
        large-pages = true;
        mode = "auto";
        cache = 2;
      };

      pools = [
        {
          # url = "xmr-eu1.nanopool.org:10343";
          url = "xmr-eu2.nanopool.org:10343";
          # url = "pool.supportxmr.com:8080";
          user = "48rmufMfAAiHH4N8q7wzdrdvcN7AXcgwTN2oEqCrCnBafCeyFaZNjZbG6ytK4BsnpUZnLuRMAstaeSpDs3JKg4qrT3x1K2K";
          algo = "rx/wow";
          keepalive = true;
          tls = true;
        }
      ];

      systemd.services.xmrig = {
        enable = true;
        after = [ "network.target" ];
      };

    };
  };
}
