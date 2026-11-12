{ config, ... }:
let
  colors = config.lib.stylix.colors;
in
{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
    ];
    userSettings = {
      telemetry.metrics = false;
      theme_overrides."Base16 ${colors.scheme-name}" = {
        "title_bar.background" = "#${colors.base00}";
        "panel.background" = "#${colors.base00}";
        "surface.background" = "#${colors.base00}";
        "title_bar.inactive_background" = "#${colors.base00}";
      };
    };
  };
}
