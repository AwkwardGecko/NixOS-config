{
  lib,
  pkgs,
  config,
  ...
}:

{
  systemd.services.dotfiles-update = {
    description = "Run a script when files in ~/.dotfiles change";

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash /home/zozano/.dotfiles/scripts/autorebuild.sh";
    };

    pathConfig = {
      PathChanged = [ "/home/zozano/.dotfiles" ];
    };
  };
}
