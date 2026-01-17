# Theme selection and overrides
# Imports base schema and selects which preset to use
{ lib, ... }: {
  imports = [ ./themes/base.nix ];

  # Select theme preset (auto-loads from ./themes/<name>/)
  theme.preset = "dark";

  # Override specific values if needed
  # theme.visual.rounding = 12;
  # theme.hyprland.gapsIn = 6;
}