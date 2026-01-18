# https://wiki.nixos.org/wiki/NixOS:nixos-rebuild
{
  inputs,
  self,
}: let
  inherit (inputs.nixpkgs) lib;
  # Imported here so mkHost doesn't need these passed as arguments.
  identity = import (self + "/cfg/identity.nix");
  themeConfig = import (self + "/cfg/theme.nix") {inherit lib;};
in {
  # Wraps lib.nixosSystem with project conventions; keeps host files minimal.
  mkHost = {
    hostname,
    username,
    system ? "x86_64-linux",
    extraModules ? [],
    overlays ? [],
  }:
  # Fail fast with clear errors rather than cryptic eval failures.
    assert builtins.isString hostname || throw "hostname must be a string";
    assert builtins.isString username || throw "username must be a string";
    assert hostname != "" || throw "hostname cannot be empty";
    assert username != "" || throw "username cannot be empty"; let
      # Hostname injected here so identity.nix stays host-agnostic.
      identity' = identity // {inherit hostname;};
    in
      lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs self;
          identity = identity';
        };
        modules =
          [
            (self + "/cfg/hosts/${hostname}")
            (self + "/cfg/users/${username}/nixos.nix")

            {nixpkgs.overlays = [overlays.additions overlays.modifications];}

            inputs.stylix.nixosModules.stylix

            # [ Theme System ]
            # schema defines options, selection picks preset, preset provides values.
            (self + "/cfg/themes/base.nix")
            (self + "/cfg/theme.nix")
            (self + "/cfg/themes/${themeConfig.theme.preset}/default.nix")
            # [ ... ]

            # [ Build-time Assertions ]
            # Catches config drift before activation; saves debugging time.
            ({config, ...}: {
              assertions = [
                {
                  assertion = config.networking.hostName == hostname;
                  message = ''
                    [HOSTNAME MISMATCH] - BUILD BLOCKED

                    [  Expected  ]: ${hostname}
                    [ Configured ]: ${config.networking.hostName}

                    Fix flake.nix before rebuilding.
                  '';
                }
                {
                  assertion = builtins.pathExists (self + "/cfg/users/${username}");
                  message = ''
                    [USER CONFIG MISSING] - BUILD BLOCKED

                    The user directory "users/${username}" does not exist.

                    If you changed the username:
                    1. Rename "users/oldname" to "users/${username}"
                    2. Rename "home/oldname" to "home/${username}" (if on existing system)
                    3. Update ownership: chown -R ${username}:users /home/${username}
                  '';
                }
              ];
            })
            # [ ... ]

            # [ Home Manager ]
            # Inline config avoids a separate flake output; user config stays with host.
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                # Shares nixpkgs instance; avoids duplicate package downloads.
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs self;
                  identity = identity';
                  inherit (themeConfig) theme;
                };
                # Theme options available in HM context too; enables per-app theming.
                sharedModules = [(self + "/cfg/themes/base.nix") (self + "/cfg/themes/${themeConfig.theme.preset}/default.nix")];
                users.${username} = import (self + "/cfg/users/${username}/home.nix");
                backupFileExtension = "backup";
              };
            }
            # [ ... ]
          ]
          ++ extraModules;
      };
}
