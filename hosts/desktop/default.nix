{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    inputs.home-manager.nixosModules.home-manager
  ];

  networking.hostName = "desktop";

  boot.loader.limine.extraEntries = ''
    /Windows
      protocol: efi_chainload
      path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
  '';

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
