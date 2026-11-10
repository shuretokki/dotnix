{ config, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    ../../modules/nixos/nvidia.nix
    ../../modules/nixos/proton-vpn.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  networking.hostName = "desktop"; # Define your hostname.

  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  system.nixos.tags = [ (inputs.self.shortRev or inputs.self.dirtyShortRev or "dirty") ];

  boot.loader.limine.extraEntries = ''
    /Windows
      protocol: efi_chainload
      path: uuid(BD81D35E-3B71-495F-A6AA-2EAAD3BF5EF1):/EFI/Microsoft/Boot/bootmgfw.efi
  '';

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.shure = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager"
      "input"
      "video"
      "audio"
    ];
  };

  programs.nh.flake = "${config.users.users.shure.home}/dotnix";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    overwriteBackup = true;
    extraSpecialArgs = { inherit inputs; };
    users.shure = import ./home.nix;
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?
}
