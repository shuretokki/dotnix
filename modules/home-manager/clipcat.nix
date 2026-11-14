{
  services.clipcat = {
    enable = true;
    daemonSettings = {
      watcher.enable_primary = false;
      desktop_notification.long_plaintext_length = 1;
    };
  };
}
