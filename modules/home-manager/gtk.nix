{ ... }:
{
  dconf.settings."org/gnome/desktop/wm/preferences".button-layout = ":";
  gtk.gtk3.extraConfig.gtk-decoration-layout = ":";
  gtk.gtk4.extraConfig.gtk-decoration-layout = ":";
  stylix.targets.gtk.extraCss = ''
    @define-color sidebar_bg_color @window_bg_color;
    @define-color sidebar_backdrop_color @window_bg_color;
    @define-color secondary_sidebar_bg_color @window_bg_color;
    @define-color secondary_sidebar_backdrop_color @window_bg_color;
  '';
}
