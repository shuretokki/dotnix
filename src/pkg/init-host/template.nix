{ config, pkgs, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./gpu.nix
    ./boot.nix
    inputs.self.nixosModules.core
    inputs.self.nixosModules.profile''${profile^}
  ];

  system.stateVersion = "''${stateVersion}";
}
