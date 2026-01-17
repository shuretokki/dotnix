{ inputs, identity, utils, self }:
let
  overlays = import (self + "/src/overlays") { inherit inputs; };
in
{
  inherit overlays;

  nixosConfigurations =
    let
      # auto-discover hosts from hosts/ directory
      hosts = inputs.nixpkgs.lib.filterAttrs (n: v: v == "directory") (builtins.readDir (self + "/cfg/hosts"));
      mkHost = hostname: _: utils.mkHost {
        inherit hostname overlays;
        username = identity.username;
      };
    in
    builtins.mapAttrs mkHost hosts;
}
