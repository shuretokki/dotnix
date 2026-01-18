# https://wiki.nixos.org/wiki/Locales
# https://search.nixos.org/options?query=i18n.defaultLocale
{identity, ...}: {
  time.timeZone = identity.timezone;

  i18n = {
    defaultLocale = identity.locale;

    extraLocaleSettings = {
      LC_ADDRESS = identity.locale;
      LC_IDENTIFICATION = identity.locale;
      LC_MEASUREMENT = identity.locale;
      LC_MONETARY = identity.locale;
      LC_NAME = identity.locale;
      LC_NUMERIC = identity.locale;
      LC_PAPER = identity.locale;
      LC_TELEPHONE = identity.locale;
      LC_TIME = identity.locale;
    };
  };

  console = {
    enable = true;
    inherit (identity) keyMap;
    font = null;
    useXkbConfig = false;
    earlySetup = false;
  };

  location = {
    provider = "manual";
  };
}
