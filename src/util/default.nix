{
  inputs,
  self,
}: let
  inherit (inputs.nixpkgs) lib;
  identity = import (self + "/cfg/identity.nix");
  themeConfig = import (self + "/cfg/theme.nix") {inherit lib;};
in {
  mkHost = {
    hostname,
    username,
    system ? "x86_64-linux",
    extraModules ? [],
    overlays ? [],
  }:
    assert builtins.isString hostname || throw "hostname must be a string";
    assert builtins.isString username || throw "username must be a string";
    assert hostname != "" || throw "hostname cannot be empty";
    assert username != "" || throw "username cannot be empty"; let
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

            # Theme system: base options + selection + preset values
            (self + "/cfg/themes/base.nix") # Options schema
            (self + "/cfg/theme.nix") # Preset selection
            (self + "/cfg/themes/${themeConfig.theme.preset}/default.nix") # Preset values

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
                  # check if user directory exists
                  # prevent confusing "file not found" errors
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

            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                # Pass theme config to HM modules via extraSpecialArgs
                extraSpecialArgs = {
                  inherit inputs self;
                  identity = identity';
                  inherit (themeConfig) theme;
                };
                # Load theme options schema in HM context too
                sharedModules = [(self + "/cfg/themes/base.nix") (self + "/cfg/themes/${themeConfig.theme.preset}/default.nix")];
                users.${username} = import (self + "/cfg/users/${username}/home.nix");
                backupFileExtension = "backup";
              };
            }
          ]
          ++ extraModules;
      };
}
