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

    waybar = {
      styleFile = ./waybar/style.css;
      configFile = ./waybar/config.jsonc;
    };

    hyprland = {
      gaps-in = 12;
      gaps-out = 36;
      rounding = 0;
      opacity = 0.80;
      blur = "medium";
      shadow = "soft";
      animations = "snappy";
      layout = "spiral";
      borderActive = "rgba(3c3c3cff)";
      borderInactive = "rgba(1e1e1eff)";
    };

    hyprlock = {
      fontFamily = "JetBrainsMono Nerd Font";
      fontSize = 36;
    };

    stylixExclude = [
      "vscode"
      "spicetify"
      "waybar"
      "swaync"
    ];
  };
}
