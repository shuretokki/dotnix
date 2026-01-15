# Theme selection and overrides
# This file selects which theme preset to use and allows per-user customization
{ lib, ... }: {
  imports = [ ./themes/base.nix ];

  # Select theme preset (loads from ./themes/<name>/)
  theme.preset = "sh";

  # Override specific theme values if needed
  # theme.visual.rounding = 12;
  # theme.hyprland.gaps = 6;
}
