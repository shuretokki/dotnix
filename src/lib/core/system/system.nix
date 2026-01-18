# https://wiki.nixos.org/wiki/Flakes
# https://search.nixos.org/options?query=nix.settings
{
  config,
  lib,
  identity,
  inputs,
  ...
}: let
  cfg = config.library.core.system;
in {
  options.library.core.system = {
    flakePath = lib.mkOption {
      type = lib.types.str;
      default = "/home/${identity.username}/dotnix";
      description = "Path to the NixOS flake for nh";
    };
  };

  config = {
    nix = {
      registry.nixpkgs.flake = inputs.nixpkgs;
      nixPath = ["nixpkgs=${inputs.nixpkgs}"];

      settings = {
        auto-optimise-store = true;
        experimental-features = ["nix-command" "flakes"];
        trusted-users = ["root" "@wheel"];
      };
    };

    networking.hostName = lib.mkDefault identity.hostname;

    # Required for saving GNOME/GTK app settings.
    programs.dconf.enable = true;

    # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/programs/nh.nix
    programs.nh = {
      enable = true;

      clean = {
        enable = true;
        extraArgs = "--keep-since 4d --keep 3";
      };

      flake = cfg.flakePath;
    };
  };
}
