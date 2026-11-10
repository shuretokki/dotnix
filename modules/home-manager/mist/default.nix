{ config, pkgs, ... }:
let
  mist = (import ../../../pkgs pkgs).mist;
  colors = config.lib.stylix.colors;
in
{
  home.packages = [
    mist
  ]
  ++ (with pkgs; [
    grim
    hyprpicker
    imagemagick
    slurp
    wl-clipboard
  ]);

  home.file.".local/share/mist/shell".source = "${mist}/share/mist";

  xdg.configFile."mist/themes/stylix.json".text = builtins.toJSON {
    name = "Stylix";
    accent = "#${colors.base0D}";
    tone = "#${colors.base00}";
    window_top = "#${colors.base01}";
    window_bottom = "#${colors.base00}";
  };

  wayland.windowManager.hyprland.extraLuaFiles.mist = ./mist.lua;
}
