{ inputs, ... }:
{
  imports = [
    inputs.zapfast.homeManagerModules.default
    inputs.framr.homeManagerModules.default
    ../../modules/home-manager
    # ../../modules/home-manager/mist
    # ../../modules/home-manager/chillpill-shell
    ../../modules/home-manager/macshell
  ];

  home = {
    username = "shure";
    homeDirectory = "/home/shure";
    stateVersion = "25.11";
  };

  theme.mactahoe = {
    enable = true;
    zen.enable = true;
  };

  programs.zapfast.enable = true;
  programs.framr.enable = true;

  wayland.windowManager.hyprland.extraLuaFiles.monitor = ./monitor.lua;
}
