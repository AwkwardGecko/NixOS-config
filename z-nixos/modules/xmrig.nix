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
          url = "xmr-eu1.nanopool.org:14444";
          user = "48rmufMfAAiHH4N8q7wzdrdvcN7AXcgwTN2oEqCrCnBafCeyFaZNjZbG6ytK4BsnpUZnLuRMAstaeSpDs3JKg4qrT3x1K2K";
          keepalive = true;
          tls = true;
        }
      ];
    };
  };
}
