# https://linrunner.de/tlp
# https://search.nixos.org/options?query=services.tlp
{
  config,
  lib,
  ...
}: let
  cfg = config.library.core.power;
in {
  options.library.core.power = {
    enable = lib.mkEnableOption "Power management (TLP) for laptops";
  };

  config = lib.mkIf cfg.enable {
    services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        DISK_IDLE_SECS_ON_AC = 0;
        DISK_IDLE_SECS_ON_BAT = 2;

        WIFI_PWR_ON_AC = "off";
        WIFI_PWR_ON_BAT = "on";

        USB_AUTOSUSPEND = 1;

        RUNTIME_PM_ON_AC = "on";
        RUNTIME_PM_ON_BAT = "auto";

        # Battery thresholds (if supported):
        # START_CHARGE_THRESH_BAT0 = 40;
        # STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };

    # Conflicts with TLP.
    services.power-profiles-daemon.enable = false;
  };
}
