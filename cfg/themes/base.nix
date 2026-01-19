# Options schema; values set by presets in ./dark/, etc.
{lib, ...}: {
  options.theme = {
    preset = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Theme preset to load from cfg/themes/";
    };

    scheme = lib.mkOption {
      type = lib.types.path;
      description = "Path to base16 color scheme YAML";
    };

    polarity = lib.mkOption {
      type = lib.types.enum ["dark" "light"];
      default = "dark";
      description = "Color scheme polarity";
    };

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

    wallpaper = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Path to the main wallpaper image";
    };

    icons = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "Papirus-Dark";
        description = "Icon theme name";
      };
    };

    vicinae = {
      opacity = lib.mkOption {
        type = lib.types.float;
        default = 0.44;
        description = "Vicinae window opacity";
      };
    };

    hyprland = {
      borderSize = lib.mkOption {
        type = lib.types.int;
        default = 2;
        description = "Window border width in pixels";
      };
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
      opacity = lib.mkOption {
        type = lib.types.float;
        default = 0.9;
        description = "Window opacity (0.0-1.0)";
      };
      blur = lib.mkOption {
        type = lib.types.enum ["none" "subtle" "medium" "heavy"];
        default = "medium";
        description = "Blur effect intensity";
      };
      shadow = lib.mkOption {
        type = lib.types.enum ["none" "soft" "sharp" "dramatic"];
        default = "soft";
        description = "Window shadow style";
      };
      animations = lib.mkOption {
        type = lib.types.enum ["none" "minimal" "smooth" "snappy" "fancy"];
        default = "smooth";
        description = "Animation style";
      };
      layout = lib.mkOption {
        type = lib.types.enum ["dwindle-equal" "dwindle-master" "spiral" "master"];
        default = "dwindle-equal";
        description = "Window layout style";
      };
      borderActive = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        example = "rgba(3c3c3cff)";
        description = "Active border color (fallback: scheme base0D)";
      };
      borderInactive = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        example = "rgba(1e1e1eff)";
        description = "Inactive border color (fallback: scheme base03)";
      };
    };

    hypridle = {
      lockTimeout = lib.mkOption {
        type = lib.types.int;
        default = 300;
        description = "Seconds before screen locks";
      };
      dpmsTimeout = lib.mkOption {
        type = lib.types.int;
        default = 330;
        description = "Seconds before display turns off";
      };
    };

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

    sddm = {
      wallpaper = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
        description = "Wallpaper for SDDM login screen";
      };
    };

    stylixExclude = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Apps with custom theming (excluded from Stylix)";
    };
  };
}
