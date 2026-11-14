{ inputs, ... }:
{
  imports = [
    inputs.zapfast.homeManagerModules.default
    inputs.framr.homeManagerModules.default
    ../../modules/home-manager
    ../../modules/home-manager/macshell
  ];

  home = {
    username = "shure";
    homeDirectory = "/home/shure";
    stateVersion = "25.11";
  };

  programs.zapfast.enable = true;
  programs.framr.enable = true;

  wayland.windowManager.hyprland.extraLuaFiles.monitor = ./monitor.lua;
}
