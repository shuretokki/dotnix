{ inputs, pkgs, ... }:
{
  home.packages = [ inputs.hylki.packages.${pkgs.stdenv.hostPlatform.system}.default ];
}
