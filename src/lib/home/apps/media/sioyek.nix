# Sioyek — PDF viewer for technical books
# https://sioyek.info/
{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.lib.stylix) colors;
in {
  stylix.targets.sioyek.enable = lib.mkForce false;
  programs.sioyek = let
    toRGB = c: "${toString (builtins.fromJSON colors."${c}-dec-r" / 255.0)} ${toString (builtins.fromJSON colors."${c}-dec-g" / 255.0)} ${toString (builtins.fromJSON colors."${c}-dec-b" / 255.0)}";
    toRGBA = c: "${toString (builtins.fromJSON colors."${c}-dec-r" / 255.0)} ${toString (builtins.fromJSON colors."${c}-dec-g" / 255.0)} ${toString (builtins.fromJSON colors."${c}-dec-b" / 255.0)} 1.0";
  in {
    enable = lib.mkDefault true;
    package = pkgs.symlinkJoin {
      name = "sioyek-wayland-fix";
      paths = [pkgs.sioyek];
      nativeBuildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/sioyek --set QT_QPA_PLATFORM xcb
      '';
    };

    # https://home-manager-options.extranix.com/?query=programs.sioyek.config
    config = {
      "should_launch_new_window" = "1";
      "show_doc_path" = "1";
      "status_bar_font_size" = "12";

      "background_color" = toRGB "base00";
      "custom_background_color" = toRGB "base00";
      "custom_text_color" = toRGB "base05";

      "status_bar_color" = toRGB "base01";
      "status_bar_text_color" = toRGB "base05";

      "ui_background_color" = toRGB "base01";
      "ui_text_color" = toRGB "base05";
      "ui_selected_background_color" = toRGB "base02";
      "ui_selected_text_color" = toRGB "base05";

      "visual_mark_color" = toRGBA "base02";
      "search_highlight_color" = toRGB "base0A";
      "link_highlight_color" = toRGB "base0D";
      "synctex_highlight_color" = toRGB "base0B";
    };
  };

  xdg.mimeApps.defaultApplications."application/pdf" = lib.mkDefault "sioyek.desktop";
}
