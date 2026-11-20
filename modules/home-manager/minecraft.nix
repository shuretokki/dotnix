{ pkgs, ... }:
{
  home.packages = [ (import ../../pkgs pkgs).millida-launcher ];
}
