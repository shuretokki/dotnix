{ lib, pkgs, ... }:
let
  inherit (lib) mkOption types;
in
{
  # Theme options schema - defines what themes can configure
  # Actual values are set by theme presets in cfg/themes/
  options.theme = {
    scheme = mkOption {
      type = types.path;
      description = "Path to base16 scheme yaml file";
    };

    polarity = mkOption {
      type = types.enum [ "dark" "light" ];
      default = "dark";
      description = "Theme polarity";
    };

    fonts = {
      serif = mkOption {
        type = types.str;
        default = "New York";
        description = "Serif font family";
      };
      sans = mkOption {
        type = types.str;
        default = "SF Pro Rounded";
        description = "Sans-serif font family";
      };
      mono = mkOption {
        type = types.str;
        default = "JetBrainsMono Nerd Font";
        description = "Monospace font family";
      };
      size = mkOption {
        type = types.int;
        default = 12;
        description = "Base font size";
      };
    };

    cursor = {
      name = mkOption {
        type = types.str;
        default = "macOS";
        description = "Cursor theme name";
      };
      size = mkOption {
        type = types.int;
        default = 24;
        description = "Cursor size in pixels";
      };
    };

    wallpaper = mkOption {
      type = types.path;
      description = "Path to the main wallpaper image (used by stylix)";
    };

    wallpaperDir = mkOption {
      type = types.path;
      description = "Path to the wallpapers directory (for symlinks)";
    };

    grub = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable custom GRUB theming";
      };

      theme = mkOption {
        type = types.package;
        description = "GRUB theme package to use";
        default = pkgs.stdenv.mkDerivation {
          pname = "wuthering-grub-theme";
          version = "1.0";
          src = pkgs.fetchFromGitHub {
            owner = "vinceliuice";
            repo = "Wuthering-grub2-themes";
            rev = "ed3f8bcd292e7a0684f3c30f20939710d263a321";
            sha256 = "sha256-q9TLZTZI/giwKu8sCTluxvkBG5tyan7nFOqn4iGLnkA=";
          };
          installPhase = ''
            mkdir -p $out
            cp -a $src/common/*.pf2 $out/
            cp -a $src/config/theme-1080p.txt $out/theme.txt
            cp -a $src/backgrounds/background-jinxi.jpg $out/background.jpg
            cp -a $src/assets/assets-icons/icons-1080p $out/icons
            cp -a $src/assets/assets-other/other-1080p/*.png $out/
          '';
        };
      };
    };

    waybar = {
      styleFile = mkOption {
        type = types.nullOr types.path;
        default = null;
        description = "Path to waybar style.css file";
      };

      configFile = mkOption {
        type = types.nullOr types.path;
        default = null;
        description = "Path to waybar config.jsonc file";
      };
    };

    hyprland = {
      gaps-in = mkOption {
        type = types.int;
        default = 4;
        description = "Inner gaps between windows";
      };
      gaps-out = mkOption {
        type = types.int;
        default = 4;
        description = "Outer gaps from screen edges";
      };
      rounding = mkOption {
        type = types.int;
        default = 0;
        description = "Corner rounding radius";
      };
      blur = mkOption {
        type = types.bool;
        default = true;
        description = "Enable blur effects";
      };
      shadows = mkOption {
        type = types.bool;
        default = true;
        description = "Enable window shadows";
      };
      active-border-col = mkOption {
        type = types.str;
        default = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        description = "Active window border color";
      };
      inactive-border-col = mkOption {
        type = types.str;
        default = "rgba(595959aa)";
        description = "Inactive window border color";
      };
    };

    hyprlock = {
      fontFamily = mkOption {
        type = types.str;
        default = "SF Pro Rounded";
        description = "Lock screen font family";
      };
      fontSize = mkOption {
        type = types.int;
        default = 64;
        description = "Lock screen clock font size";
      };
      input-field = {
        size = mkOption {
          type = types.str;
          default = "300, 50";
          description = "Input field size (width, height)";
        };
        outline_thickness = mkOption {
          type = types.int;
          default = 2;
          description = "Input field outline thickness";
        };
        dots_size = mkOption {
          type = types.float;
          default = 0.33;
          description = "Password dot size";
        };
        dots_spacing = mkOption {
          type = types.float;
          default = 0.15;
          description = "Password dot spacing";
        };
      };
    };
  };
}
