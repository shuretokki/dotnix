# https://home-manager-options.extranix.com/?query=services.network-manager-applet
# https://home-manager-options.extranix.com/?query=services.blueman-applet
# https://home-manager-options.extranix.com/?query=services.udiskie
# https://home-manager-options.extranix.com/?query=services.playerctld
# https://home-manager-options.extranix.com/?query=services.kdeconnect
{lib, ...}: {
  services = {
    network-manager-applet.enable = lib.mkDefault true;
    blueman-applet.enable = lib.mkDefault true;
    udiskie.enable = lib.mkDefault true;
    playerctld.enable = lib.mkDefault true;

    # phone integration (notifications, clipboard, file transfer)
    kdeconnect = {
      enable = lib.mkDefault true;
      indicator = true;
    };
  };
}
