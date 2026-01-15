# Base theme options schema
# This defines the theme.* options that all theme presets and display modules use
# Actual values are set in theme presets (./dark/, ./sh/, etc.)
{ lib, ... }: {
  options.theme = {
    preset = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Theme preset to load from cfg/themes/";
    };

    # Visual settings shared across all components
    visual = {
      rounding = lib.mkOption { type = lib.types.int; default = 8; };
      opacity = lib.mkOption { type = lib.types.float; default = 0.9; };
      blur = lib.mkOption { type = lib.types.bool; default = true; };
    };

    # Hyprland-specific appearance
    hyprland = {
      gaps = lib.mkOption { type = lib.types.int; default = 4; };
      borderSize = lib.mkOption { type = lib.types.int; default = 2; };
      activeBorder = lib.mkOption {
        type = lib.types.str;
        default = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      };
      inactiveBorder = lib.mkOption {
        type = lib.types.str;
        default = "rgba(595959aa)";
      };
    };

    # Apps excluded from Stylix
    stylixExclude = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Apps with custom theming (excluded from Stylix)";
    };
  };
}
