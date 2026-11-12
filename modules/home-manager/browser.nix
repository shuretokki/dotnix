{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser = {
    enable = true;

    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = lib.mkForce true;
      OfferToSaveLogins = false;
      SanitizeOnShutdown = false;
      HttpsOnlyMode = "force_enabled";
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };

    profiles.default = {
      extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
        ublock-origin
        bitwarden
        darkreader
        sponsorblock
        auto-tab-discard
        clearurls
        privacy-badger
      ];

      search = {
        force = true;
        default = "google";
        order = [
          "google"
          "Youtube"
          "NixOS Options"
          "Nix Packages"
          "GitHub"
          "MDN"
          "Arch Wiki"
          "Crates.io"
        ];
        engines = {
          "NixOS Options" = {
            urls = [ { template = "https://search.nixos.org/options?query={searchTerms}"; } ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@no" ];
          };
          "Nix Packages" = {
            urls = [ { template = "https://search.nixos.org/packages?query={searchTerms}"; } ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "GitHub" = {
            urls = [ { template = "https://github.com/search?q={searchTerms}&type=repositories"; } ];
            definedAliases = [ "@gh" ];
          };
          "MDN" = {
            urls = [ { template = "https://developer.mozilla.org/en-US/search?q={searchTerms}"; } ];
            definedAliases = [ "@mdn" ];
          };
          "Arch Wiki" = {
            urls = [ { template = "https://wiki.archlinux.org/index.php?search={searchTerms}"; } ];
            definedAliases = [ "@aw" ];
          };
          "Crates.io" = {
            urls = [ { template = "https://crates.io/search?q={searchTerms}"; } ];
            definedAliases = [ "@crates" ];
          };
          "Youtube" = {
            urls = [ { template = "https://www.youtube.com/results?search_query={searchTerms}"; } ];
            definedAliases = [ "@yt" ];
          };
          "google".metaData.alias = "@g";
        };
      };

      settings = {
        "media.peerconnection.enabled" = true;
        "zen.view.sidebar-only" = true;
        "zen.view.vertical-tabs.show-new-tab-button" = true;
        "zen.view.vertical-tabs.new-tab-button-at-top" = true;
        "zen.view.compact.toolbar-flash-popup" = false;
        "zen.glance.enabled" = true;
        "zen.glance.trigger-modifier" = "alt";
        "zen.theme.content-element-separation" = 0;
      };
    };
  };

  programs.firefox = {
    enable = true;
    profiles.default = { };
  };

  stylix.targets.firefox.profileNames = [ "default" ];
}
