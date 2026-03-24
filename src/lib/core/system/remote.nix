{lib, pkgs, ...}: {
  # TeamViewer allows remote control and screen mirroring from phone to PC.
  # Note: You'll need the TeamViewer QuickSupport or Host app on your phone.
  # services.teamviewer.enable = lib.mkDefault true;

  # Android Debug Bridge (ADB) - required for scrcpy and phone integration.
  # Note: programs.adb is deprecated in favor of systemd uaccess rules.
  environment.systemPackages = [ pkgs.android-tools ];
}
