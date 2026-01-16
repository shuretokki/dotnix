# Base theme options schema
# Defines theme.* options used by all theme presets and display modules
# Values are set by presets in ./dark/, etc.
{ lib, ... }: {
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
      serif = lib.mkOption {
        type = lib.types.str;
        default = "New York";
        description = "Serif font family";
      };
      sans = lib.mkOption {
        type = lib.types.str;
        default = "SF Pro Rounded";
        description = "Sans-serif font family";
      };
      mono = lib.mkOption {
        type = lib.types.str;
        default = "JetBrainsMono Nerd Font";
        description = "Monospace font for terminals";
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

    # Hyprland-specific (kebab-case to match existing code)
    hyprland = {
      gaps-in = lib.mkOption {
        type = lib.types.int;
        default = 4;
        description = "Inner gaps between windows";
      };
      gaps-out = lib.mkOption {
        type = lib.types.int;
        default = 4;
        description = "Outer gaps to screen edge";
      };
      rounding = lib.mkOption {
        type = lib.types.int;
        default = 0;
        description = "Window corner rounding";
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
      active-border-col = lib.mkOption {
        type = lib.types.str;
        default = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        description = "Active window border color";
      };
      inactive-border-col = lib.mkOption {
        type = lib.types.str;
        default = "rgba(595959aa)";
        description = "Inactive window border color";
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
      input-field = {
        size = lib.mkOption {
          type = lib.types.str;
          default = "300, 50";
          description = "Input field size (width, height)";
        };
        outline_thickness = lib.mkOption {
          type = lib.types.int;
          default = 2;
          description = "Input field outline thickness";
        };
        dots_size = lib.mkOption {
          type = lib.types.float;
          default = 0.33;
          description = "Password dot size";
        };
        dots_spacing = lib.mkOption {
          type = lib.types.float;
          default = 0.15;
          description = "Password dot spacing";
        };
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

    # SDDM login manager
    sddm = {
      wallpaper = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
        description = "Wallpaper for SDDM login screen";
      };
    };

    # Apps excluded from Stylix theming
    stylixExclude = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Apps with custom theming (excluded from Stylix)";
    };
  };

  # NOTE: Preset auto-loading causes infinite recursion if done here
  # Presets are loaded in src/util/default.nix
}
