{ inputs, pkgs, ... }:
{
  home.packages = [ inputs.coucou.packages.${pkgs.stdenv.hostPlatform.system}.default ];
}
