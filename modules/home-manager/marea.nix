{ inputs, pkgs, ... }:
{
  home.packages = [ inputs.marea.packages.${pkgs.stdenv.hostPlatform.system}.default ];
}
