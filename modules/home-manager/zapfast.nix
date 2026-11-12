{ config, lib, ... }:
let
  colors = config.lib.stylix.colors;
in
{
  config = lib.mkIf config.programs.zapfast.enable {
    programs.zapfast.settings.custom_theme = "stylix.json";

    xdg.configFile."zapfast/themes/stylix.json".text = builtins.toJSON {
      base = if config.stylix.polarity == "light" then "light" else "dark";
      colors = {
        window = "#${colors.base00}";
        panel = "#${colors.base00}";
        surface = "#${colors.base02}";
        outline = "#${colors.base03}";
        text = "#${colors.base05}";
        secondary = "#${colors.base04}";
        dim = "#${colors.base03}";
        accent = "#${colors.base0D}";
        on_accent = "#${colors.base00}";
        danger = "#${colors.base08}";
        warning = "#${colors.base0A}";
      };
    };
  };
}
