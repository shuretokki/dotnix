{ inputs, repo, alias, identity, utils }: {
  overlays = import ../../overlays { inherit inputs repo alias; };

  # Auto-discover hosts from hosts/ directory
  nixosConfigurations =
    let
      hosts = inputs.nixpkgs.lib.filterAttrs (n: v: v == "directory") (builtins.readDir ./../../../hosts);
    in
    inputs.nixpkgs.lib.genAttrs (builtins.attrNames hosts) (
      hostname: utils.mkHost {
        inherit hostname repo alias;
        username = identity.username;
        overlays = [
          overlays.additions
          overlays.modifications
        ];
      }
    );
}
