# validation assertions for early misconfiguration detection
# these run at nix evaluation time, before any build starts.
{
  config,
  lib,
  identity,
  ...
}: let
  # usernames that should not be used as primary user
  reservedUsernames = [
    "root"
    "bin"
    "daemon"
    "sys"
    "nobody"
    "www-data"
    "lp"
    "games"
    "mail"
    "sync"
    "shutdown"
    "halt"
    "uucp"
    "operator"
  ];

  # Theme path validation - theme now comes from config.theme.preset (cfg/theme.nix)
  themePreset = config.theme.preset or "default";
  themePath = ../../../../cfg/themes + "/${themePreset}/default.nix";
in {
  config.assertions = [
    {
      assertion = identity.username != "";
      message = "identity.username must not be empty";
    }

    {
      assertion = builtins.match "^[a-z_][a-z0-9_-]{0,31}$" identity.username != null;
      message = "identity.username '${identity.username}' is not a valid UNIX username (lowercase, start with letter/underscore, max 32 chars)";
    }
    {
      assertion = !builtins.elem identity.username reservedUsernames;
      message = "identity.username '${identity.username}' is a reserved system username. Choose a different name.";
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
  ];

  config.systemd.services.sops-key-check = {
    description = "check sops key file exists";
    wantedBy = ["multi-user.target"];
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
