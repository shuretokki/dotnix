# https://wiki.hypr.land/Configuring/Window-Rules/
{
  windowrule = [
    "match:class ^(pavucontrol)$, float 1"
    "match:class ^(blueman-manager)$, float 1"
    "match:class ^(nm-connection-editor)$, float 1"
    "match:class ^(localsend_app)$, float 1"
    "match:class ^(org.gnome.Nautilus)$, float 1"
    "match:title ^(About)(.*)$, float 1"
    "match:class ^(xdg-desktop-portal-gtk)$, float 1"

    "match:class ^(localsend_app)$, size 800 600"
    "match:class ^(localsend_app)$, center 1"

    "match:class ^(warp-terminal)$, opacity 0.95"
    "match:class ^(Spotify)$, opacity 0.9"

    "match:class ^(Spotify)$, workspace 5"
    "match:class ^(localsend_app)$, workspace 4"
    "match:class ^(discord)$, workspace 3"

    "match:class ^(xwayland)$, opacity 1.0 override"

    "match:class ^(hyprshot)$, no_anim 1"
  ];

  layerrule = [
    "no_anim 1, match:namespace selection"
    "no_anim 1, match:namespace hyprpicker"
    "no_anim 1, match:namespace slurp"
    "no_anim 1, match:namespace hyprshot"

    "blur 1, match:namespace vicinae"
    "ignore_alpha 0, match:namespace vicinae"
    # "no_anim 1, match:namespace vicinae"
  ];
}
