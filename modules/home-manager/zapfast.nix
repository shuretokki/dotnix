{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  colors = config.lib.stylix.colors;
in
{
  config = lib.mkIf config.programs.zapfast.enable {
    programs.zapfast.package =
      inputs.zapfast.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs
        (old: {
          checkFlags = (old.checkFlags or [ ]) ++ [ "--skip=the_rail_is_a_shade_darker_than_the_list" ];
          postPatch = (old.postPatch or "") + ''
            substituteInPlace src/theme.rs \
              --replace-fail 'const DARK_RAIL_SHADE: f32 = 0.22;' 'const DARK_RAIL_SHADE: f32 = 0.0;'
          '';
        });

    programs.zapfast.settings.custom_theme = "stylix.json";

    xdg.configFile."zapfast/themes/stylix.json".text = builtins.toJSON {
      base = if config.stylix.polarity == "light" then "light" else "dark";
      colors = {
        window = "#${colors.base00}";
        panel = "#${colors.base00}";
        surface = "#${colors.base02}";
        outline = "#${colors.base02}";
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
