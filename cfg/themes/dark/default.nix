# Dark theme preset
# Sets values for theme.* options defined in base.nix
{ pkgs, ... }: {
  theme = {
    # Color scheme
    scheme = ./scheme.yaml;
    polarity = "dark";

    # Fonts
    fonts = {
      mono = "JetBrainsMono Nerd Font";
      sans = "SF Pro Rounded";
      size = 12;
    };

    # Cursor
    cursor = {
      name = "macOS";
      size = 24;
    };

    # Wallpaper
    wallpaperDir = if builtins.pathExists ./wallpapers then ./wallpapers else ../default/wallpapers;

    # Visual
    visual = {
      rounding = 0;
      opacity = 0.9;
      blur = true;
    };

    # Hyprland (using camelCase to match schema)
    hyprland = {
      gapsIn = 4;
      gapsOut = 4;
      borderSize = 2;
      rounding = 0;
      activeBorder = "rgba(3c3c3cff)";
      inactiveBorder = "rgba(1e1e1eff)";
      blur = true;
      shadows = true;
    };

    # Hyprlock
    hyprlock = {
      fontFamily = "SF Pro Rounded";
      fontSize = 64;
    };

    # Apps with custom styling (excluded from Stylix)
    stylixExclude = [
      "vscode"
      "spicetify"
      "waybar"
      "swaync"
    ];
  };
}
