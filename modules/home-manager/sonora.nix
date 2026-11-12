{ config, inputs, ... }:
let
  colors = config.lib.stylix.colors;
in
{
  imports = [ inputs.sonora.homeModules.default ];

  programs.sonora = {
    enable = true;
    settings.appearance = {
      theme = "dark";
      theme_overrides = {
        background = colors.base00;
        foreground = colors.base05;
        border = colors.base02;
        muted = colors.base01;
        muted_foreground = colors.base04;
        secondary = colors.base01;
        secondary_hover = colors.base02;
        secondary_active = colors.base03;
        primary = colors.base0D;
        primary_foreground = colors.base07;
        danger = colors.base08;
        danger_foreground = colors.base07;
        popover = colors.base01;
        popover_foreground = colors.base05;
        progress_bar = colors.base0D;
        selection = colors.base02;
        sidebar = colors.base00;
        sidebar_accent = colors.base02;
        sidebar_border = colors.base02;
        title_bar_border = colors.base02;
        table_head = colors.base01;
        table_row_border = colors.base02;
        table_hover = colors.base01;
        table_active = colors.base02;
      };
    };
  };
}
