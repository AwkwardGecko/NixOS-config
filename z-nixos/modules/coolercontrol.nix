{ config, lib, pkgs, ... }:
{

   programs.coolercontrol.enable = true;

   environment.systemPackages = with pkgs; [
      coolercontrol.coolercontrol-liqctld     
   ];
}
