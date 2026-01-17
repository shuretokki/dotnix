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

    # Visual
    visual = {
      rounding = 0;
      opacity = 0.88;
      blur = true;
    };

    # Hyprland (kebab-case to match schema)
    hyprland = {
      gaps-in = 12;
      gaps-out = 12;
      rounding = 0;
      blur = true;
      shadows = true;
      active-border-col = "rgba(3c3c3cff)";
      inactive-border-col = "rgba(1e1e1eff)";
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
