# desktop host configuration.
# imports core modules and desktop profile.
# hardware-specific toggles (nvidia, docker) set here.

{ config, pkgs, identity, inputs, ... }: {
  imports = [
    inputs.self.nixosModules.core
    inputs.self.nixosModules.profileDesktop
    ./hardware-configuration.nix
    ./gpu.nix
    ./boot.nix
  ];

  # library.core.gpu.nvidia.open = false; # Example override
  library.core.virtualisation.docker.enable = true;

  system.stateVersion = "25.11";
}
