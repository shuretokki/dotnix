{
  services.dnscrypt-proxy = {
    enable = true;
    settings = {
      server_names = [
        "quad9-doh-ip4-nofilter-ecs-pri"
        "cloudflare"
      ];
      listen_addresses = [ "127.0.0.1:53" ];
      require_dnssec = true;
      require_nolog = true;
      require_nofilter = true;
      ipv6_servers = false;
      block_ipv6 = true;
    };
  };

  networking.nameservers = [ "127.0.0.1" ];
  networking.networkmanager.dns = "none";
}
