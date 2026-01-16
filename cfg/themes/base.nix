# Base theme options schema
# Defines theme.* options used by all theme presets and display modules
# Values are set by presets in ./dark/, etc.
{ config, lib, ... }:
let
  cfg = config.theme;
in
{
  options.theme = {
    preset = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Theme preset to load from cfg/themes/";
    };

    # Base16 color scheme
    scheme = lib.mkOption {
      type = lib.types.path;
      description = "Path to base16 color scheme YAML";
    };

    polarity = lib.mkOption {
      type = lib.types.enum [ "dark" "light" ];
      default = "dark";
      description = "Color scheme polarity";
    };

    # Fonts
    fonts = {
      mono = lib.mkOption {
        type = lib.types.str;
        default = "JetBrainsMono Nerd Font";
        description = "Monospace font for terminals and code";
      };
      sans = lib.mkOption {
        type = lib.types.str;
        default = "SF Pro Rounded";
        description = "Sans-serif font for UI";
      };
      size = lib.mkOption {
        type = lib.types.int;
        default = 12;
        description = "Base font size";
      };
    };

    # Cursor
    cursor = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "macOS";
        description = "Cursor theme name";
      };
      size = lib.mkOption {
        type = lib.types.int;
        default = 24;
        description = "Cursor size in pixels";
      };
    };

    # Wallpaper
    wallpaperDir = lib.mkOption {
      type = lib.types.path;
      description = "Directory containing wallpapers";
    };

    # Visual settings shared across components
    visual = {
      rounding = lib.mkOption {
        type = lib.types.int;
        default = 8;
        description = "Corner rounding in pixels";
      };
      opacity = lib.mkOption {
        type = lib.types.float;
        default = 0.9;
        description = "Window opacity (0.0-1.0)";
      };
      blur = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable blur effects";
      };
    };

    # Hyprland-specific (using camelCase to match plan)
    hyprland = {
      gapsIn = lib.mkOption {
        type = lib.types.int;
        default = 4;
        description = "Inner gaps between windows";
      };
      gapsOut = lib.mkOption {
        type = lib.types.int;
        default = 4;
        description = "Outer gaps to screen edge";
      };
      borderSize = lib.mkOption {
        type = lib.types.int;
        default = 2;
        description = "Window border width";
      };
      rounding = lib.mkOption {
        type = lib.types.int;
        default = 0;
        description = "Window corner rounding (separate from visual.rounding)";
      };
      activeBorder = lib.mkOption {
        type = lib.types.str;
        default = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        description = "Active window border color";
      };
      inactiveBorder = lib.mkOption {
        type = lib.types.str;
        default = "rgba(595959aa)";
        description = "Inactive window border color";
      };
      blur = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable Hyprland blur";
      };
      shadows = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable window shadows";
      };
    };

    # Hyprlock
    hyprlock = {
      fontFamily = lib.mkOption {
        type = lib.types.str;
        default = "SF Pro Rounded";
        description = "Lock screen font";
      };
      fontSize = lib.mkOption {
        type = lib.types.int;
        default = 64;
        description = "Lock screen font size";
      };
    };

    # Waybar
    waybar = {
      styleFile = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
        description = "Path to waybar style.css file";
      };
      configFile = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
        description = "Path to waybar config.jsonc file";
      };
    };

    # Apps excluded from Stylix theming
    stylixExclude = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Apps with custom theming (excluded from Stylix)";
    };
  };

  # NOTE: Preset auto-loading cannot be done here (causes infinite recursion)
  # Preset is loaded in src/util/default.nix via sharedModules
}
