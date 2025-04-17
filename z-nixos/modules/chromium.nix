{ config, lib, pkgs }:

{
  programs.chromium = {
    enable = true;
    extraOpts = {
      "homepage" = "http://localhost:8188";
      "session.restore_on_startup" = 4; # Open specific set of URLs
      "session.startup_urls" = [ "http://localhost:8188" ];
      "browser.show_home_button" = false;
      "profile.default_content_setting_values.notifications" = 2;
      "profile.default_content_setting_values.geolocation" = 2;
      "credentials_enable_service" = false;
      "profile.password_manager_enabled" = false;
      "background_mode.enabled" = false;
      "metrics_reporting_enabled" = false;
      "profile.exit_type" = "Normal";
    };
  };
}
