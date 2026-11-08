{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    configType = "lua";
    systemd.enable = false;
    extraLuaFiles = {
      keybindings = ./keybindings.lua;
      rules = ./rules.lua;
    };
  };
}
