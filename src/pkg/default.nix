{ pkgs }:
let
  detect-gpu = pkgs.callPackage ./detect-gpu { };
  detect-boot-uuids = pkgs.callPackage ./detect-boot-uuids { };
in {
  # Custom packages - hardcoded names (sdn = shuredotnix)
  "sdn-update" = pkgs.callPackage ./sys-update { };

  "captive-portal" = pkgs.callPackage ./captive-portal { };

  "detect-gpu" = detect-gpu;
  "detect-boot-uuids" = detect-boot-uuids;

  "sdn-init-host" = pkgs.callPackage ./sdn-init-host {
    inherit detect-gpu detect-boot-uuids;
  };
}
