{ inputs, pkgs, ... }:
{
  home.packages = [ inputs.hyprfm.packages.${pkgs.stdenv.hostPlatform.system}.default ];
}
