{ inputs, repo, alias, identity, utils, root }:
let
  overlays = import (root + "/src/overlays") { inherit inputs repo alias; };
in
{
  inherit overlays;

  nixosConfigurations =
    let
      # auto-discover hosts from hosts/ directory
      hosts = inputs.nixpkgs.lib.filterAttrs (n: v: v == "directory") (builtins.readDir (root + "/hosts"));
      mkHost = hostname: _: utils.mkHost {
        inherit hostname repo alias overlays;
        username = identity.username;
      };
    in
    builtins.mapAttrs mkHost hosts;
}
