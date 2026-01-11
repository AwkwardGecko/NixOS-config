##################
### AUTO LOGIN ###
##################

{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.displayManager = {
    sddm.enable = true;
    autoLogin = {
      enable = true;
      user = "zozano";
    };
  };
}
