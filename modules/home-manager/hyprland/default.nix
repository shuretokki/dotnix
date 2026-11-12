{
  config,
  lib,
  pkgs,
  ...
}:
let
  colors = config.lib.stylix.colors;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    configType = "lua";
    systemd.enable = false;
    plugins = with pkgs.hyprlandPlugins; [
      borders-plus-plus
      hyprbars
    ];
    settings.config = {
      general."col.active_border" = lib.mkForce "rgb(${colors.base02})";
      general."col.inactive_border" = lib.mkForce "rgb(${colors.base02})";
      decoration.shadow.color = lib.mkForce "rgb(${colors.base02})";
      plugin.borders_plus_plus = {
        add_borders = 1;
        natural_rounding = false;
        col.border_1 = "rgb(${colors.base00})";
        border_size_1 = 2;
      };
      plugin.hyprbars = {
        bar_height = 28;
        bar_color = "rgb(${colors.base00})";
        bar_blur = false;
        bar_precedence_over_border = true;
        bar_text_font = config.stylix.fonts.sansSerif.name;
        bar_text_size = 11;
        bar_text_align = "center";
        bar_buttons_alignment = "left";
        bar_padding = 12;
        bar_button_padding = 8;
        bar_part_of_window = true;
        icon_on_hover = true;
        col.text = "rgb(${colors.base05})";
        on_double_click = "hyprctl dispatch 'hl.dsp.window.fullscreen({ mode = \"maximized\", action = \"toggle\" })'";
      };
    };
    extraLuaFiles = {
      animations = ./animations.lua;
      behavior = ./options/behavior.lua;
      blur = ./options/blur.lua;
      cursor = ./options/cursor.lua;
      group = ./options/group.lua;
      hyprbars = ./hyprbars.lua;
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
