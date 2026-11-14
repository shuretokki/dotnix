{ pkgs, ... }:
{
  home.packages = [ (import ../../pkgs pkgs).explorist ];

  home.sessionVariables = {
    GDK_DEBUG = "portals";
    GTK_USE_PORTAL = "1";
  };
}
