# https://wiki.hypr.land/Configuring/Variables/
{
  config,
  lib,
  ...
}: let
  inherit (config.lib.stylix) colors;
  theme = config.theme.hyprland;
  presets = import ./presets.nix {inherit colors;};

  blur = presets.blur.${theme.blur};
  shadow = presets.shadow.${theme.shadow};
  layout = presets.layout.${theme.layout};
  anim = presets.animations.${theme.animations};

  withDefault = value: default:
    if value != null
    then value
    else default;

  activeBorder = withDefault theme.borderActive "rgba(${colors.base0D}ff)";
  inactiveBorder = withDefault theme.borderInactive "rgba(${colors.base03}ff)";
  forceAll = lib.mapAttrs (_: lib.mkForce);
in {
  general = {
    gaps_in = lib.mkForce theme.gaps-in;
    gaps_out = lib.mkForce theme.gaps-out;
    border_size = lib.mkForce theme.borderSize;
    "col.active_border" = lib.mkForce activeBorder;
    "col.inactive_border" = lib.mkForce inactiveBorder;
    layout =
      if theme.layout == "master"
      then "master"
      else "dwindle";
  };

  decoration = {
    inherit (theme) rounding;
    active_opacity = lib.mkForce theme.opacity;
    inactive_opacity = lib.mkForce theme.opacity;
    blur = {
      inherit (blur) enabled size passes;
      new_optimizations = true;
      ignore_opacity = true;
      xray = false;
    };
    shadow = forceAll {
      inherit (shadow) enabled range render_power color;
    };
  };

  dwindle = layout;

  animations = {
    inherit (anim) enabled bezier animation;
  };

  plugin = {
    hyprbars = {
      bar_height = 24;
      bar_part_of_window = true;
      bar_title_enabled = false;
      bar_precedence_over_border = true;
      bar_buttons_alignment = "left";
      bar_color = "rgba(${colors.base00}ff)";
      bar_blur = "on";
      bar_padding = 12;
      bar_button_padding = 9;

      "hyprbars-button" = [
        "rgb(${colors.base08}), 13, , hyprctl dispatch killactive"
        "rgb(${colors.base0A}), 13, , hyprctl dispatch fullscreen 1"
      ];
    };
  };

  misc = {
    vfr = true;
    vrr = 1;
    focus_on_activate = true;
    animate_manual_resizes = true;
    animate_mouse_windowdragging = true;
    enable_swallow = true;
    swallow_regex = "^(warp-terminal)$";
    disable_hyprland_logo = true;
    force_default_wallpaper = 0;
    allow_session_lock_restore = true;
    initial_workspace_tracking = false;
  };

  cursor = {
    no_hardware_cursors = true;
    enable_hyprcursor = true;
    warp_on_change_workspace = true;
  };
}
