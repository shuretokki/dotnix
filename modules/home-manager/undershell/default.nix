{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.undershell;
  undershell = (import ../../../pkgs pkgs).undershell;
in
{
  options.programs.undershell.enable = lib.mkEnableOption "desktop widgets that pass behind the wallpaper subject";

  config = lib.mkIf cfg.enable {
    home.packages = [ undershell ];
    wayland.windowManager.hyprland.extraLuaFiles.undershell = ./undershell.lua;
  };
}
