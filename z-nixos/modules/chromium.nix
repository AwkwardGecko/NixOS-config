{ config, lib, pkgs, ... }:

{
  hardware.bluetooth.enable = true;
  services.blueman.enable = false; # set true if you want a GUI tray

  programs.chromium = {
    enable = true;

    # Add the runtime flag Chromium expects on Linux for Web Bluetooth.
    commandLineArgs = [
      "--enable-experimental-web-platform-features"
    ];

    # Make sure policy isn’t silently blocking the API.
    extraOpts = {
      "DefaultWebBluetoothGuardSetting" = 3;  # 3 = allow sites to ask
      "homepage" = "http://localhost:8188";
      "session.restore_on_startup" = 4;
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

  environment.systemPackages = with pkgs; [
    chromium
    bluez
  ];
}

