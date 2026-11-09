{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    configType = "lua";
    systemd.enable = false;
    extraLuaFiles = {
      animations = ./animations.lua;
      behavior = ./options/behavior.lua;
      blur = ./options/blur.lua;
      cursor = ./options/cursor.lua;
      group = ./options/group.lua;
      input = ./options/input.lua;
      keybindings = ./keybindings.lua;
      layouts = ./options/layouts.lua;
      look = ./options/look.lua;
      motion = ./options/motion.lua;
      rules = ./rules.lua;
      system = ./options/system.lua;
      touch = ./options/touch.lua;
    };
  };
}
