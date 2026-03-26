{ config, lib, pkgs, ... }:
let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in
{
  programs = {
    chromium = {
      enable = true;

      # Make sure policy isn’t silently blocking the API.
      extraOpts = {
        "DefaultWebBluetoothGuardSetting" = 3; # 3 = allow sites to ask
        "homepage" = "https://app.storz-bickel.com";
        "session.restore_on_startup" = 4;
        "session.startup_urls" = [ "https://app.storz-bickel.com" ];
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
  programs = {
    firefox = {
      enable = true;
      languagePacks = [
        "en-GB"
      ];

      # ---- POLICIES ----
      # Check about:policies#documentation for options.
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisablePocket = true;
        DisableFirefoxScreenshots = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        DontCheckDefaultBrowser = true;
        DisplayBookmarksToolbar = "always"; # alternatives: "always" or "newtab"
        DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
        SearchBar = "unified"; # alternative: "separate"

        SearchEngines = {
          Default = "Ecosia";
          Add = [
            {
              Name = "Ecosia";
              URLTemplate = "https://www.ecosia.org/search?q={searchTerms}";
              IconURL = "https://www.ecosia.org/static/icons/favicon.ico";
              Alias = "@ecosia";
              Description = "Ecosia - the search engine which fucks and sucks lol";
              Method = "GET";
            }
          ];
          Remove = [ "Bing" "Amazon.com" ];
        };

        # ---- EXTENSIONS ----
        # Check about:support for extension/add-on ID strings.
        # Valid strings for installation_mode are "allowed", "blocked",
        # "force_installed" and "normal_installed".
        ExtensionSettings = {
          #"*".installation_mode = "blocked"; # blocks all addons except the ones specified below

          # uBlock Origin:
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };

          # Proton Pass:
          "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi";
            installation_mode = "force_installed";
          };

          # Proton VPN:
          "vpn@proton.ch" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-vpn-firefox-extension/latest.xpi";
            installation_mode = "force_installed";
          };

          # Privacy Badger:
          "jid1-MnnxcxisBPnSXQ@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
            installation_mode = "force_installed";
          };

          # Aussie English Language Pack:
          "en-AU@dictionaries.addons.mozilla.org" = {
            install_url = "https://addons.mozilla.org/en-GB/firefox/addon/english-australian-dictionary/latest.xpi";
            installation_mode = "forced_install";
          };
        };

        # ---- PREFERENCES ----
        # Check about:config for options.
        Preferences = {
          "browser.contentblocking.category" = {
            Value = "strict";
            Status = "locked";
          };
          "extensions.pocket.enabled" = lock-false;
          "extensions.screenshots.disabled" = lock-true;
          "browser.topsites.contile.enabled" = lock-false;
          "browser.formfill.enable" = lock-false;
          "browser.search.suggest.enabled" = lock-false;
          "browser.search.suggest.enabled.private" = lock-false;
          "browser.urlbar.suggest.searches" = lock-false;
          "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
          "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
          "browser.newtabpage.activity-stream.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
        };
      };
    };
  };

  };



  environment.systemPackages = with pkgs; [
    chromium
    bluez
    proton-pass
  ];
}
