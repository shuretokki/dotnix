pkgs: {
  cap = pkgs.callPackage ./cap.nix { };
  lean-ctx = pkgs.callPackage ./lean-ctx.nix { };
  mactahoe-icon-theme = pkgs.callPackage ./mactahoe-icon-theme.nix { };
  macshell = pkgs.callPackage ./macshell { };
  open-runde = pkgs.callPackage ./open-runde.nix { };
  qylock-sddm = pkgs.callPackage ./qylock-sddm.nix { };
}
