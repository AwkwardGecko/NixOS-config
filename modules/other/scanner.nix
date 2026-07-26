{ config, lib, pkgs, ... }:
{
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.sane-airscan ];

  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;

  users.users.zozano.extraGroups = [ "scanner" "lp" ];
}
