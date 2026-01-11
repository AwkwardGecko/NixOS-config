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
      "01 * * * * && dex ~/.local/share/applications/teamviewer.desktop"
    ];
  };
}
