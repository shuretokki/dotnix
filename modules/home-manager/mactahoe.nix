{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.theme.mactahoe;
  mactahoe = (import ../../pkgs pkgs).mactahoe-gtk-theme;
  themeName = "MacTahoe-Dark";

  palette = config.lib.stylix.colors {
    template = "${inputs.stylix}/modules/gtk/gtk.css.mustache";
    extension = ".css";
  };

  libadwaitaCss = pkgs.runCommandLocal "gtk-4.0.css" { } ''
    echo '@import url("file://${mactahoe}/share/themes/${themeName}/gtk-4.0/gtk.css");' >$out
    cat ${palette} >>$out
    echo ${lib.escapeShellArg config.stylix.targets.gtk.extraCss} >>$out
  '';

  zen = config.programs.zen-browser;
  chrome = "${zen.profilesPath}/${zen.profiles.default.path}/chrome";
  firefoxTheme = "${mactahoe}/share/mactahoe-firefox";
in
{
  options.theme.mactahoe = {
    enable = lib.mkEnableOption "the MacTahoe GTK theme with the Stylix palette on top";
    zen.enable = lib.mkEnableOption "the MacTahoe userChrome theme in Zen";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      gtk.theme.package = lib.mkForce mactahoe;
      gtk.theme.name = lib.mkForce themeName;
      xdg.configFile."gtk-4.0/gtk.css".source = lib.mkForce libadwaitaCss;
    })

    (lib.mkIf (cfg.enable && cfg.zen.enable) {
      programs.zen-browser.profiles.default.settings."toolkit.legacyUserProfileCustomizations.stylesheets" =
        true;
      home.file = {
        "${chrome}/userChrome.css".source = "${firefoxTheme}/userChrome.css";
        "${chrome}/customChrome.css".source = "${firefoxTheme}/customChrome.css";
        "${chrome}/MacTahoe".source = "${firefoxTheme}/MacTahoe";
      };
    })
  ];
}
