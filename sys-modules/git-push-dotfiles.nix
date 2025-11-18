{ pkgs, config, lib, ... }:

{
  systemd.services.push-dotfiles = {
    description = "Push dotfiles to GitHub";
    script = ''
      /home/zozano/.dotfiles/scripts/git-push-dotfiles.sh
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "zozano";
    };
  };

  systemd.timers.push-dotfiles = {
    description = "Timer to push dotfiles hourly";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "hourly";
      Persistent = true;
    };
  };
}

