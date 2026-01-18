# laptop profile: extends desktop with power management.
# enables TLP by default for battery optimization.
{lib, ...}: {
  imports = [
    ../desktop
  ];

  # Enable TLP for battery management
  library.core.power.enable = lib.mkDefault true;
}
