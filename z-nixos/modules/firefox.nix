{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.firefox = {
    enable = true;
    settings = {
      # Disable telemetry and data collection
      "toolkit.telemetry.enabled" = false;
      "toolkit.telemetry.archive.enabled" = false;
      "datareporting.healthreport.uploadEnabled" = false;
      "browser.ping-centre.telemetry" = false;

      # Disable Pocket and DRM (Widevine)
      "extensions.pocket.enabled" = false;
      "media.gmp-widevinecdm.enabled" = false;

      # Enable tracking protection
      "privacy.trackingprotection.enabled" = true;
      "privacy.trackingprotection.pbmode.enabled" = true;

      # Security tweaks
      "security.cert_pinning.enforcement_level" = 2;
      "network.dns.disablePrefetch" = true;
      "browser.cache.disk.enable" = false;
      "browser.cache.memory.enable" = true;
    };


  };
}

