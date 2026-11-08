{
  # Flakes are the only way this repository builds the system.
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # A timer deduplicates the store in the background, so builds stay fast.
  nix.optimise.automatic = true;
}
