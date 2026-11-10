{
  inputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    enable = true;
    base16Scheme = {
      base00 = "000000";
      base01 = "0b0b0d";
      base02 = "1c1c1e";
      base03 = "636366";
      base04 = "8e8e93";
      base05 = "f5f5f7";
      base06 = "e5e5ea";
      base07 = "ffffff";
      base08 = "ff453a";
      base09 = "ff9f0a";
      base0A = "ffd60a";
      base0B = "30d158";
      base0C = "64d2ff";
      base0D = "0a84ff";
      base0E = "bf5af2";
      base0F = "ac8e68";
    };
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
