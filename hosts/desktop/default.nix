{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    inputs.home-manager.nixosModules.home-manager
  ];

  networking.hostName = "desktop";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.limine = {
    enable = true;
    maxGenerations = 10;
    enableEditor = false;
    extraEntries = ''
      /Windows
        protocol: efi_chainload
        path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
    '';
  };

  users.users.shure = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
      "video"
      "audio"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.shure = import ./home.nix;
  };

  system.stateVersion = "25.11";
}
