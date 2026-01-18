# Bundles network modules.
{...}: {
  imports = [
    ./network.nix
    ./dns.nix
  ];
}
