# https://wiki.nixos.org/wiki/NixOS_modules#Option_types
{
  config,
  lib,
  ...
}: let
  cfg = config.library.profile;
in {
  options.library.profile = lib.mkOption {
    type = lib.types.enum ["desktop" "laptop" "server"];
    description = ''
      System profile type. Determines which hardware/power defaults apply.
      - `desktop`: Performance-oriented, no power management.
      - `laptop`: Battery optimization, lid/suspend handling.
      - `server`: Headless, minimal services.
    '';
  };

  # Only one profile can be active.
  config = lib.mkMerge [
    (lib.mkIf (cfg == "desktop") (import ./desktop {
      inherit (config) lib;
      inherit (config) identity;
    }))
    (lib.mkIf (cfg == "laptop") (import ./laptop {
      inherit (config) lib;
      inherit (config) identity;
    }))
    (lib.mkIf (cfg == "server") (import ./server {
      inherit (config) lib;
      inherit (config) identity;
    }))
  ];
}
