# validation assertions for early misconfiguration detection
# these run at nix evaluation time, before any build starts.

{ config, lib, identity, repo, alias, ... }:
let
  validGroups = [
    "wheel"
    "networkmanager"
    "video"
    "audio"
    "input"
    "libvirtd"
    "adbusers"
    "docker"
    "tss"
    "uucp"
    "operator"
  ];

  # Theme path validation - theme now comes from config.theme.preset (cfg/theme.nix)
  themePreset = config.theme.preset or "default";
  themePath = ../../../../cfg/themes + "/${themePreset}/default.nix";
in
{
  config.assertions = [
    {
      assertion = identity.username != "";
      message = "identity.username must be set";
    }
    {
      assertion = builtins.match "^[a-z_][a-z0-9_-]{0,31}$" identity.username != null;
      message = "identity.username '${identity.username}' is not a valid UNIX username (lowercase, start with letter/underscore, max 32 chars)";
    }
    {
      assertion = identity.locale != "";
      message = "identity.locale must be set (e.g., 'en_US.UTF-8')";
    }
    {
      assertion = identity.timezone != "";
      message = "identity.timezone must be set (e.g., 'America/New_York')";
    }
    {
      assertion = themePreset != "";
      message = "theme.preset must be set in cfg/theme.nix";
    }
    {
      assertion = builtins.pathExists themePath;
      message = "Theme '${themePreset}' does not exist. Expected path: ${toString themePath}";
    }

    {
      assertion = config.library.core.sops.keyFile != "";
      message = "library.core.sops.keyFile must be configured";
    }

    {
      assertion = alias == "sdn";
      message = ''
        [PROJECT IDENTITY MISMATCH]
        The project alias is set to "${alias}", but "sdn" is required.
        This protects structural aliases like sdn-update and cdsdn.

        If you ARE sure about this change:
        1. Update alias in flake.nix
        2. Update this assertion in library/core/validations.nix
      '';
    }

    {
      assertion = repo == "dotnix";
      message = ''
        [PROJECT REPO MISMATCH]
        The project repo is set to "${repo}", but "dotnix" is required.
        This protects hardcoded paths in scripts and system configs.

        If you ARE sure about this change:
        1. Update repo in flake.nix
        2. Update this assertion in library/core/validations.nix
      '';
    }
  ];

  config.systemd.services.sops-key-check = {
    description = "check sops key file exists";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      KEY_FILE="${config.library.core.sops.keyFile}"
      if [ ! -f "$KEY_FILE" ]; then
        echo "[WARNING] SOPS key file not found at $KEY_FILE"
        echo "Secrets decryption will fail. Run: age-keygen -o $KEY_FILE"
      else
        echo "[INFO   ] SOPS key file found at $KEY_FILE"
      fi
    '';
  };
}
