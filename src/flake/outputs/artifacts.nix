# https://wiki.nixos.org/wiki/Flakes#Output_schema
{
  inputs,
  identity,
  utils,
  self,
}: let
  # Defined here so all hosts share the same overlay set without duplication.
  overlays = import (self + "/src/overlays") {inherit self;};
in {
  inherit overlays;

  nixosConfigurations = let
    # Auto-discovery avoids manually listing each host; adding a folder is enough.
    hosts = inputs.nixpkgs.lib.filterAttrs (_: v: v == "directory") (builtins.readDir (self + "/cfg/hosts"));
    # Wraps boilerplate (nixpkgs, home-manager, modules) so host files stay minimal.
    mkHost = hostname: _:
      utils.mkHost {
        inherit hostname overlays;
        inherit (identity) username;
      };
  in
    builtins.mapAttrs mkHost hosts;
}
