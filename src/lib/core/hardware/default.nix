# Bundles all hardware modules.
{...}: {
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./input.nix
    ./fonts.nix
    ./power.nix
    ./gpu
  ];
}
