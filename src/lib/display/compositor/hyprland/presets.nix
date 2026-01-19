# Hyprland appearance presets
# Imported by appearance.nix; uses colors from Stylix
{colors}: {
  blur = {
    none = {
      enabled = false;
      size = 0;
      passes = 0;
    };
    subtle = {
      enabled = true;
      size = 3;
      passes = 1;
    };
    medium = {
      enabled = true;
      size = 5;
      passes = 3;
    };
    heavy = {
      enabled = true;
      size = 8;
      passes = 4;
    };
  };

  shadow = {
    none = {
      enabled = false;
      range = 0;
      render_power = 0;
      color = "0x00000000";
    };
    soft = {
      enabled = true;
      range = 15;
      render_power = 3;
      color = "rgba(${colors.base00}88)";
    };
    sharp = {
      enabled = true;
      range = 8;
      render_power = 5;
      color = "rgba(${colors.base00}aa)";
    };
    dramatic = {
      enabled = true;
      range = 25;
      render_power = 2;
      color = "rgba(${colors.base00}cc)";
    };
  };

  layout = {
    dwindle-equal = {
      pseudotile = false;
      preserve_split = true;
      force_split = 0;
    };
    dwindle-master = {
      pseudotile = false;
      preserve_split = true;
      force_split = 2;
    };
    spiral = {
      pseudotile = false;
      preserve_split = false;
      force_split = 0;
    };
    master = {};
  };

  animations = {
    none = {
      enabled = false;
      bezier = [];
      animation = [];
    };
    minimal = {
      enabled = true;
      bezier = [
        "linear, 0, 0, 1, 1"
      ];
      animation = [
        "windows, 1, 2, linear"
        "fade, 1, 2, linear"
        "workspaces, 1, 2, linear, slide"
      ];
    };
    smooth = {
      enabled = true;
      bezier = [
        "md3_decel, 0.05, 0.7, 0.1, 1"
        "md3_accel, 0.3, 0, 0.8, 0.15"
        "softAcDecel, 0.26, 0.26, 0.15, 1"
      ];
      animation = [
        "windows, 1, 3, md3_decel, popin 60%"
        "windowsIn, 1, 3, md3_decel, popin 60%"
        "windowsOut, 1, 3, md3_accel, popin 60%"
        "border, 1, 10, default"
        "fade, 1, 3, md3_decel"
        "workspaces, 1, 2.5, softAcDecel, slide"
      ];
    };
    snappy = {
      enabled = true;
      bezier = [
        "snap, 0.2, 1, 0.3, 1"
        "snapOut, 0.5, 0, 0.9, 0.5"
      ];
      animation = [
        "windows, 1, 2, snap, popin 80%"
        "windowsOut, 1, 2, snapOut, popin 80%"
        "fade, 1, 2, snap"
        "workspaces, 1, 2, snap, slide"
      ];
    };
    fancy = {
      enabled = true;
      bezier = [
        "overshot, 0.05, 0.9, 0.1, 1.1"
        "crazy, 0.1, 1.5, 0.76, 0.92"
        "menu_decel, 0.1, 1, 0, 1"
        "menu_accel, 0.38, 0.04, 1, 0.07"
        "easeOutExpo, 0.16, 1, 0.3, 1"
      ];
      animation = [
        "windows, 1, 4, overshot, popin 60%"
        "windowsIn, 1, 4, overshot, popin 60%"
        "windowsOut, 1, 3, menu_accel, popin 60%"
        "border, 1, 10, default"
        "fade, 1, 4, easeOutExpo"
        "layers, 1, 3, menu_decel, slide"
        "layersIn, 1, 4, menu_decel, slide"
        "layersOut, 1, 3, menu_accel, slide"
        "workspaces, 1, 4, overshot, slide"
        "specialWorkspace, 1, 4, crazy, slidevert"
      ];
    };
  };
}
