pkgs: {
  cap = pkgs.callPackage ./cap.nix { };
  lean-ctx = pkgs.callPackage ./lean-ctx.nix { };
  mactahoe-icon-theme = pkgs.callPackage ./mactahoe-icon-theme.nix { };
  # mactahoe-gtk-theme = pkgs.callPackage ./mactahoe-gtk-theme.nix { };
  macshell = pkgs.callPackage ./macshell { };
  qylock-sddm = pkgs.callPackage ./qylock-sddm.nix { };
}
