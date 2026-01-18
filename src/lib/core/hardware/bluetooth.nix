# https://wiki.nixos.org/wiki/Bluetooth
# https://search.nixos.org/options?query=hardware.bluetooth
{
  config,
  lib,
  ...
}: let
  cfg = config.library.core.bluetooth;
in {
  options.library.core.bluetooth = {
    enable = lib.mkEnableOption "Bluetooth hardware support";
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      hsphfpd.enable = false;
      disabledPlugins = [];

      settings = {
        General = {
          ControllerMode = "dual";
          Discoverable = false;
          DiscoverableTimeout = 0;
          AlwaysPairable = false;
          PairableTimeout = 0;
          Experimental = false;
        };
        Policy = {
          AutoEnable = true;
        };
      };

      input = {
        General = {
          ClassicBondedOnly = true;
        };
      };

      network = {
        General = {
          DisableSecurity = false;
        };
      };
    };

    services.blueman.enable = true;
  };
}
