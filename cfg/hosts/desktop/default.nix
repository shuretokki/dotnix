# Host-specific ; hardware toggles and profile selection.
{
  inputs,
  ...
}: {
  imports = [
    ./gpu.nix
    ./boot.nix
    ./hardware-configuration.nix
    inputs.self.nixosModules.core
    inputs.self.nixosModules.profileDesktop
  ];

  library.core.virtualisation.docker.enable = true;

  system.stateVersion = "25.11";
}
