{ inputs, ... }:
{
  imports = [ inputs.chillpill-shell.homeManagerModules.default ];

  programs.chillpill-shell.enable = true;

  wayland.windowManager.hyprland.extraLuaFiles.chillpill = ./chillpill.lua;
}
