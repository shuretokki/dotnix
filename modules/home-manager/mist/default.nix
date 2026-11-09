{ pkgs, ... }:
let
  mist = (import ../../../pkgs pkgs).mist;
in
{
  home.packages = [ mist ];

  home.file.".local/share/mist/shell".source = "${mist}/share/mist";

  wayland.windowManager.hyprland.extraLuaFiles.mist = ./mist.lua;
}
