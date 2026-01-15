{ pkgs, ... }: {
  theme = {
    # Base16 color scheme
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

    wallpaperDir = if builtins.pathExists ./wallpapers then ./wallpapers else ../../default/wallpapers;

    # Visual settings
    visual = {
      rounding = 0;
      opacity = 0.9;
      blur = true;
    };

    # Hyprland-specific
    hyprland = {
      rounding = 0;
      gaps-in = 4;
      gaps-out = 4;
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
  };
}
