{ config, pkgs, ... }:

{
  services.xmrig = {
    enable = true;
    settings = {

      autosave = true;
      cpu = true;
      opencl = false;
      cuda = false;
     
      pools = [
        {
          url = "xmr-eu1.nanopool.org:10343";
          user = "48rmufMfAAiHH4N8q7wzdrdvcN7AXcgwTN2oEqCrCnBafCeyFaZNjZbG6ytK4BsnpUZnLuRMAstaeSpDs3JKg4qrT3x1K2K";
          algo = "rx/wow";
          keepalive = true;
          tls = true;
        }
      ];
    };
  };
}
