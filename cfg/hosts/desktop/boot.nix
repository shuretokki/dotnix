_: {
  boot.dualBoot.windows = {
    enable = true;
    uuid = "bd81d35e-3b71-495f-a6aa-2eaad3bf5ef1";
  };

  # Secure Boot Setup (default is disabled):
  #   1. nix-shell -p sbctl --run "sudo sbctl create-keys"
  #   2. Enter BIOS → Clear Secure Boot keys (enters "Setup Mode")
  #   3. nix-shell -p sbctl --run "sudo sbctl enroll-keys -m -f"
  #   4. Set boot.loader.limine.secureBoot.enable = true
  #   5. Rebuild, then enable Secure Boot in BIOS
  # Use -m flag to include Microsoft keys (for Windows dual boot).
  boot.loader.limine.secureBoot.enable = true;
}
