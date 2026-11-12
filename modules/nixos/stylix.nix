{
  inputs,
  pkgs,
  ...
}:
let
  scheme = "amoled";
in
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    enable = true;
    base16Scheme = ../../themes/${scheme}.yaml;
    polarity = "dark";

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };
    };

    cursor = {
      package = pkgs.apple-cursor;
      name = "macOS";
      size = 24;
    };

    icons = {
      enable = true;
      package = pkgs.whitesur-icon-theme;
      dark = "WhiteSur-dark";
      light = "WhiteSur-light";
    };

    targets.limine.enable = false;
  };
}
