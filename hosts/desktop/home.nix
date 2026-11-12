{
  imports = [
    ../../modules/home-manager
    # ../../modules/home-manager/mist
    ../../modules/home-manager/chillpill-shell
  ];

  home = {
    username = "shure";
    homeDirectory = "/home/shure";
    stateVersion = "25.11";
  };

  wayland.windowManager.hyprland.extraLuaFiles.monitor = ./monitor.lua;
}
