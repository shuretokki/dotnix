{ pkgs, ... }:
{
  home.packages = [ (import ../../../pkgs pkgs).tide-island ];

  wayland.windowManager.hyprland.extraLuaFiles.tide-island = ./tide-island.lua;
}
