{ inputs, pkgs, ... }:
let
  serein = inputs.serein.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  home.packages = [
    (serein.overrideAttrs (old: {
      env = (old.env or { }) // {
        CARGO_PROFILE_RELEASE_DEBUG = "0";
      };
    }))
  ];
}
