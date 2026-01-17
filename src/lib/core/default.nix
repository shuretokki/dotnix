{...}: {
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./system
    ./hardware
    ./network
    ./security
  ];
}
