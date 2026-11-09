{ pkgs, ... }:
{
  home.packages = [ (import ../../pkgs pkgs).lean-ctx ];
}
