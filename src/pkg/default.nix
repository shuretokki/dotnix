{ pkgs }:
let
  detect-gpu = pkgs.callPackage ./detect-gpu { };
  detect-boot-uuids = pkgs.callPackage ./detect-boot-uuids { };
in {
  "update" = pkgs.callPackage ./update { };
  "captive-portal" = pkgs.callPackage ./captive-portal { };
  "detect-gpu" = detect-gpu;
  "detect-boot-uuids" = detect-boot-uuids;
  "init-host" = pkgs.callPackage ./init-host {
    inherit detect-gpu detect-boot-uuids;
  };
}
