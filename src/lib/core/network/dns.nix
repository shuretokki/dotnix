# https://wiki.nixos.org/wiki/Encrypted_DNS
# https://search.nixos.org/options?query=services.dnscrypt-proxy
{pkgs, ...}: let
  stateDir = "dnscrypt-proxy";
  blocklistFile = "/var/lib/${stateDir}/blocked-names.txt";
in {
  services.dnscrypt-proxy = {
    enable = true;

    settings = {
      # https://github.com/DNSCrypt/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml
      # https://dnscrypt.info/public-servers
      server_names = ["quad9-doh-ip4-nofilter-ecs-pri" "cloudflare" "mullvad-doh"];
      listen_addresses = ["127.0.0.1:53"];
      doh_servers = true;

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        cache_file = "/var/lib/${stateDir}/public-resolvers.md";
      };

      blocked_names = {
        blocked_names_file = blocklistFile;
        log_file = "/var/log/dnscrypt-proxy/blocked-names.log";
      };

      require_dnssec = true;
      require_nolog = true;
      require_nofilter = true;

      # IPv6 caused binding issues.
      ipv6_servers = false;
      block_ipv6 = true;
    };
  };

  systemd.services = {
    dnscrypt-proxy = {
      serviceConfig.StateDirectory = stateDir;

      # Ensure blocklist exists before start.
      preStart = ''
        mkdir -p /var/lib/${stateDir}
        if [ ! -f ${blocklistFile} ]; then
          touch ${blocklistFile}
        fi
      '';
    };

    dnscrypt-blocklist = {
      description = "Update OISD blocklist for dnscrypt-proxy";
      after = ["network.target"];
      serviceConfig = {
        Type = "oneshot";
        User = "root";
      };
      script = ''
        URL="https://small.oisd.nl/"
        TMP_FILE="/tmp/oisd-blocked-names.txt"

        ${pkgs.curl}/bin/curl -sL "$URL" -o "$TMP_FILE"

        if [ -s "$TMP_FILE" ]; then
          mv "$TMP_FILE" ${blocklistFile}
          chmod 644 ${blocklistFile}
          echo "Blocklist updated successfully."
          systemctl try-reload-or-restart dnscrypt-proxy
        else
          echo "Failed to download blocklist."
          rm -f "$TMP_FILE"
          exit 1
        fi
      '';
    };
  };

  systemd.timers.dnscrypt-blocklist = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      RandomizedDelaySec = "1h";
    };
  };

  networking.nameservers = ["127.0.0.1"];

  # Prevent NetworkManager from overwriting resolv.conf.
  networking.networkmanager.dns = "none";

  # Avoid port 53 conflicts.
  services.resolved.enable = false;

  environment.systemPackages = with pkgs; [
    dnsutils
    whois
    traceroute
    mtr
    captive-portal
  ];
}
