{
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.limine = {
    enable = true;
    # Maximum number of latest generations in the boot menu. Useful to prevent boot partition of running out of disk space.
    maxGenerations = 10;
    # It is recommended to set this to false, as it allows gaining root access by passing `init=/bin/sh` as a kernel parameter.
    enableEditor = false;
  };
}
