pkgs: {
  macshell = pkgs.callPackage ./macshell.nix { };
  pixie-sddm = pkgs.callPackage ./pixie-sddm.nix { };
}
