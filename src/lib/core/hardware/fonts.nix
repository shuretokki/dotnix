# https://wiki.nixos.org/wiki/Fonts
# https://search.nixos.org/options?query=fonts
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.library.core.fonts;
in {
  options.library.core.fonts = {
    enable = lib.mkEnableOption "Font configuration and packages";
  };

  config = lib.mkIf cfg.enable {
    fonts = {
      fontDir.enable = true;
      enableDefaultPackages = true;

      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        # fira
        # source-han-sans
        # source-han-serif
        # inter
        # eb-garamond

        nerd-fonts.jetbrains-mono

        inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-pro
        inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-mono
        inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.ny
      ];
    };

    fonts.fontconfig = {
      enable = true;
      antialias = true;

      hinting = {
        enable = true;
        autohint = false;
        style = "slight";
      };

      subpixel = {
        lcdfilter = "default";
        rgba = "rgb";
      };

      defaultFonts = {
        serif = [config.theme.fonts.serif "Liberation Serif" "Noto Serif"];
        sansSerif = [config.theme.fonts.sans "SF Pro Rounded" "Inter" "Noto Sans"];
        monospace = [config.theme.fonts.mono "JetBrainsMono Nerd Font"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
