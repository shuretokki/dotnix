# Build-time warnings for common misconfigurations.
{
  lib,
  config,
  identity,
  ...
}: let
  expectedStateVersion = "25.11";
in {
  warnings =
    lib.optional (config.system.stateVersion != expectedStateVersion) ''
      [STATEVERSION MISMATCH] system.stateVersion != ${expectedStateVersion}
      Current: ${config.system.stateVersion}
      Expected: ${expectedStateVersion}

      This is allowed for mixed-version fleets but be aware of potential
      data migration issues (e.g. PostgreSQL) when upgrading state.
    ''
    ++ lib.optional (identity.timezone == "UTC") ''
      Using default timezone "UTC"
      Set your timezone in identity.nix: timezone = "Asia/Jakarta";
    ''
    ++ lib.optional (config.theme.preset == "default") ''
      Using default theme;
    '';
}
