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

      donate-level = 0;
      
      # CPU settings
      cpu-priority = 2;
      cpu-usage = 50;
      # cpu-usage = null;
      threads = 4;
      # threads = null;

      # RandomX optimizations
      randomx = {
        large-pages = true;
        mode = "auto";
        cache = 2;
      };

      pools = [
        {
          # url = "xmr-eu1.nanopool.org:10343";
          url = "pool.supportxmr.com:443";
          # url = "pool.supportxmr.com:8080";
          user = "48rmufMfAAiHH4N8q7wzdrdvcN7AXcgwTN2oEqCrCnBafCeyFaZNjZbG6ytK4BsnpUZnLuRMAstaeSpDs3JKg4qrT3x1K2K";
          pass = "somethingorothjer"
          #algo = "rx/0";
          #algo = "rx";
          keepalive = true;
          tls = true;
        }
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    xmrig-proxy
  ];

}
