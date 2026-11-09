pkgs: {
  lean-ctx = pkgs.callPackage ./lean-ctx.nix { };
  macshell = pkgs.callPackage ./macshell.nix { };
  pixie-sddm = pkgs.callPackage ./pixie-sddm.nix { };
}
