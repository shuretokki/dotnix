# https://wiki.nixos.org/wiki/Polkit
# https://wiki.nixos.org/wiki/SSH
# https://search.nixos.org/options?query=security
{config, ...}: {
  security.polkit = {
    enable = true;
    debug = false;
    # adminIdentities = [ "unix-group:wheel" ];
  };

  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    allowSFTP = true;
    openFirewall = true;

    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
      KbdInteractiveAuthentication = false;
      X11Forwarding = true;
    };
  };

  # Unlocked automatically on login when Hyprland is enabled.
  services.gnome.gnome-keyring.enable = config.library.display.hyprland.enable;
  security.pam.services.login.enableGnomeKeyring = config.library.display.hyprland.enable;
}
