# https://wiki.nixos.org/wiki/Docker
# https://wiki.nixos.org/wiki/Podman
{
  config,
  lib,
  identity,
  ...
}: let
  cfg = config.library.core.virtualisation;
in {
  options.library.core.virtualisation = {
    docker.enable = lib.mkEnableOption "Docker container runtime";
    podman.enable = lib.mkEnableOption "Podman container runtime";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.docker.enable {
      virtualisation.docker.enable = true;
      users.users.${identity.username}.extraGroups = ["docker"];
    })

    (lib.mkIf cfg.podman.enable {
      virtualisation.podman = {
        enable = true;
        dockerCompat = !cfg.docker.enable;
      };
    })
  ];
}
