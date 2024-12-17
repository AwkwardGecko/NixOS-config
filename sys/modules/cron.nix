###############
### CRONTAB ###
###############

{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.cron = {
    enable = true;
    systemCronJobs = [
    "@reboot sleep 15 && dex ~/.local/share/applications/teamviewer.desktop"
    ];
  };
}
