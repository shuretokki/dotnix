{
  # NixOS leaves the timezone unset by default, so the clock would show UTC.
  time.timeZone = "Asia/Jakarta";

  i18n.defaultLocale = "en_US.UTF-8";
}
