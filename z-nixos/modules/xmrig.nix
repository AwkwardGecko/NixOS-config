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
          url = "pool.supportxmr.com:443";
          user = "48rmufMfAAiHH4N8q7wzdrdvcN7AXcgwTN2oEqCrCnBafCeyFaZNjZbG6ytK4BsnpUZnLuRMAstaeSpDs3JKg4qrT3x1K2K";
          keepalive = true;
          tls = true;
        }
      ];
    };
  };
}
