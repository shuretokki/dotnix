# https://wiki.nixos.org/wiki/Networking
# https://wiki.nixos.org/wiki/NetworkManager
# https://search.nixos.org/options?query=networking
_: {
  networking.networkmanager = {
    enable = true;

    wifi = {
      # backend = "wpa_supplicant";
      # scanRandMacAddress = true;
    };

    # dhcp = "internal";
    # dns = "default";
    # plugins = with pkgs; [ networkmanager-openvpn ];
    # logLevel = "WARN";
    # unmanaged = [ "docker0" "br-*" ];
  };

  services.cloudflare-warp.enable = true;

  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/networking/firewall.nix
  networking.firewall = {
    enable = true;
    # backend = "iptables";

    allowedTCPPorts = [53317];
    allowedUDPPorts = [53317];

    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];

    # trustedInterfaces = [ "tailscale0" ];
    # allowPing = true;
    # logRefusedConnections = true;
    # rejectPackets = false;

    checkReversePath = false;
  };
}
