# Reference https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265
{ lib, config, ... }:
{
  programs.firefox = lib.mkIf config.programs.firefox.enable {
    preferencesStatus = "locked";
    preferences = {
      "browser.bookmarks.restore_default_bookmarks" = false;
      "browser.toolbars.bookmarks.visibility" = "never";
      "browser.urlbar.quicksuggest.enabled" = false;
      "browser.urlbar.sponsoredTopSites" = false;
      "browser.urlbar.suggest.addons" = false;
      "browser.urlbar.suggest.bookmark" = false;
      "browser.urlbar.suggest.engines" = false;
      "browser.urlbar.suggest.history" = false;
      "browser.urlbar.suggest.topsites" = false;
      "browser.urlbar.trimHttps" = false;
      "browser.sessionstore.restore_tabs_lazily" = true;
      "extensions.pocket.enabled" = false;
      "dom.security.https_only_mode" = true;
      "extensions.htmlaboutaddons.recommendations.enabled" = false;
      "browser.dataFeatureRecommendations.enabled" = false;
      "browser.translations.automaticallyPopup" = false;
      "browser.translations.enable" = true;
      "cookiebanners.service.mode" = 2;
      "cookiebanners.service.mode.privateBrowsing" = 2;
    };
    policies = {
      PasswordManagerEnabled = false;
      # Check about:support for extension/add-on ID strings.
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "normal_install";
        };
        "firefox-translations-addon@mozilla.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/firefox-translations/latest.xpi";
          installation_mode = "normal_install";
        };
      };
      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
      };
      DisableFormHistory = true;
      DisableTelemetry = true;
      DisplayMenuBar = "default-off";
      OfferToSaveLogins = false;
      PopupBlocking = {
        Default = true;
        Locked = true;
      };
      StartDownloadsInTempDirectory = true;
      SanitizeOnShutdown = {
        Cookies = true;
        Cache = true;
        FormData = true;
        Locked = true;
      };
      SearchBar = "unified";
      ShowHomeButton = false;
      Permissions = {
        Location = {
          BlockNewRequests = true;
        };
        VirtualReality = {
          BlockNewRequests = true;
        };
        Notifications = {
          BlockNewRequests = true;
        };
      };
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };
      NoDefaultBookmarks = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
      };
    };
  };
}
