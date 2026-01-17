# Profile option - single enum to select system configuration type
{
  config,
  lib,
  ...
}: let
  cfg = config.library.profile;
in {
  options.library.profile = lib.mkOption {
    type = lib.types.enum ["desktop" "laptop" "server"];
    description = "System profile type to apply";
  };

  config = lib.mkMerge [
    (lib.mkIf (cfg == "desktop") (import ./desktop {
      inherit config lib;
      identity = config.identity;
    }))
    (lib.mkIf (cfg == "laptop") (import ./laptop {
      inherit config lib;
      identity = config.identity;
    }))
    (lib.mkIf (cfg == "server") (import ./server {
      inherit config lib;
      identity = config.identity;
    }))
  ];
}
