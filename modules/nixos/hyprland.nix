{
  programs.hyprland = {
    enable = true;
    # This has improved systemd support and is recommended for most users.
    withUWSM = true;
  };

  xdg.portal.config.hyprland = {
    default = [
      "hyprland"
      "gtk"
    ];
    "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
  };
}
