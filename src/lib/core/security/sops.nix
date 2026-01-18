# https://github.com/Mic92/sops-nix
# Setup: age-keygen -o ~/.config/sops/age/keys.txt
{
  inputs,
  config,
  lib,
  identity,
  ...
}: let
  cfg = config.library.core.sops;
in {
  options.library.core.sops = {
    keyFile = lib.mkOption {
      type = lib.types.str;
      default = "/home/${identity.username}/.config/sops/age/keys.txt";
      description = "Path to SOPS age key file";
    };
  };

  imports = [inputs.sops-nix.nixosModules.sops];

  config.sops = {
    defaultSopsFile = lib.mkDefault ../../../../cfg/secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age = {
      keyFile = lib.mkDefault cfg.keyFile;
      # sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      # generateKey = true;
    };

    secrets = {
      # github_token = {};
      # user_password = { neededForUsers = true; };
    };
  };
}
