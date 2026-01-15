# User keybind overrides for Hyprland
# Use this to revoke default keybinds or add custom ones
{
  keybinds = {
    revoke = [
      # Example: Remove default keybinds you don't want
      # "SUPER, W"
      # "SUPER, J"
    ];
    add = [
      # Example: Add your custom keybinds
      # "SUPER, RETURN, exec, warp-terminal"
      # "ALT, Q, togglefloating,"
    ];
  };

  mousebinds = {
    revoke = [
      # "SUPER, mouse:272"
    ];
    add = [
      # "ALT CTRL, mouse:272, movewindow"
    ];
  };
}
