# Values for theme.* options defined in base.nix.
_: {
  theme = {
    scheme = ./scheme.yaml;
    polarity = "dark";

    fonts = {
      mono = "JetBrainsMono Nerd Font";
      sans = "SF Pro Rounded";
      size = 12;
    };

    cursor = {
      name = "macOS";
      size = 24;
    };

    visual = {
      rounding = 0;
      opacity = 0.88;
      blur = true;
    };

    waybar = {
      styleFile = ./waybar/style.css;
      configFile = ./waybar/config.jsonc;
    };

    hyprland = {
      gaps-in = 12;
      gaps-out = 36;
      rounding = 0;
      blur = true;
      shadows = true;
      active-border-col = "rgba(3c3c3cff)";
      inactive-border-col = "rgba(1e1e1eff)";
    };

    hyprlock = {
      fontFamily = "SF Pro Rounded";
      fontSize = 64;
    };

    stylixExclude = [
      "vscode"
      "spicetify"
      "waybar"
      "swaync"
    ];
  };
}
