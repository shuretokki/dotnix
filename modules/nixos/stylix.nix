{
  inputs,
  pkgs,
  ...
}:
let
  scheme = "macshell";
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
        package = (import ../../pkgs pkgs).open-runde;
        name = "Open Runde";
      };
    };

    cursor = {
      package = pkgs.apple-cursor;
      name = "macOS";
      size = 24;
    };

    icons = {
      enable = true;
      package = (import ../../pkgs pkgs).mactahoe-icon-theme;
      dark = "MacTahoe-dark";
      light = "MacTahoe-light";
    };

    targets.limine.enable = false;
  };
}
