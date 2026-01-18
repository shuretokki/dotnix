# Preset selection; values come from ./themes/<preset>/
_: {
  imports = [./themes/base.nix];

  theme.preset = "dark";

  # Override specific values if needed:
  # theme.visual.rounding = 12;
  # theme.hyprland.gapsIn = 6;
}
