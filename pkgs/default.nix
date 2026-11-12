pkgs: {
  cap = pkgs.callPackage ./cap.nix { };
  lean-ctx = pkgs.callPackage ./lean-ctx.nix { };
  macshell = pkgs.callPackage ./macshell.nix { };
  mist = pkgs.callPackage ./mist.nix { };
  pixie-sddm = pkgs.callPackage ./pixie-sddm.nix { };
  qylock-sddm = pkgs.callPackage ./qylock-sddm.nix { };
}
