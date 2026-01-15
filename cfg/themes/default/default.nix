{ pkgs, ... }: {
  # Default theme preset
  # Sets concrete values for all theme options

  theme = {
    scheme = ./default/schemes/sh-dark.yaml;
    polarity = "dark";

    fonts = {
      serif = "New York";
      sans = "SF Pro Rounded";
      mono = "JetBrainsMono Nerd Font";
      size = 12;
    };

    cursor = {
      name = "macOS";
      size = 24;
    };

    wallpaper = ./default/wallpapers/000.jpg;
    wallpaperDir = ./default/wallpapers;

    grub.enable = true;

    waybar = {
      styleFile = ./default/waybar/style.css;
      configFile = ./default/waybar/config.jsonc;
    };

    hyprland = {
      gaps-in = 4;
      gaps-out = 4;
      rounding = 0;
      blur = true;
      shadows = true;
      active-border-col = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      inactive-border-col = "rgba(595959aa)";
    };

    hyprlock = {
      fontFamily = "SF Pro Rounded";
      fontSize = 64;
      input-field = {
        size = "300, 50";
        outline_thickness = 2;
        dots_size = 0.33;
        dots_spacing = 0.15;
      };
    };
  };
}
