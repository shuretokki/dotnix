{ pkgs, ... }: {
  theme = {
    hyprland = {
      rounding = 0;
      gaps-in = 4;
      gaps-out = 4;
      blur = true;
      shadows = true;
      active-border-col = "rgba(3c3c3cff)";
      inactive-border-col = "rgba(1e1e1eff)";
    };

    hyprlock = {
      fontFamily = "SF Pro Rounded";
      fontSize = 64;
    };
  };
}
