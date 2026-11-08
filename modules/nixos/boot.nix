{
  # Limine is the boot manager on this machine.
  # Each host adds its own extra entries, such as Windows.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.limine = {
    enable = true;
    maxGenerations = 10;
    enableEditor = false;
  };
}
