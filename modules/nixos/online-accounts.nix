{ pkgs, ... }:
{
  services.gnome.gnome-online-accounts.enable = true;

  environment.systemPackages = [
    pkgs.gnome-control-center
    (pkgs.writeShellApplication {
      name = "online-accounts";
      text = ''
        XDG_CURRENT_DESKTOP=GNOME exec gnome-control-center online-accounts
      '';
    })
  ];
}
