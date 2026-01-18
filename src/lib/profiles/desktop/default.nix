{
  config,
  lib,
  pkgs,
  identity,
  inputs,
  ...
}: {
  imports = [
    inputs.self.nixosModules.display
  ];

  # mkDefault allows hosts to override.
  library = {
    core = {
      audio.enable = lib.mkDefault true;
      bluetooth.enable = lib.mkDefault true;
      fonts.enable = lib.mkDefault true;
      input.enable = lib.mkDefault true;
      files.enable = lib.mkDefault true;
    };

    display = {
      sddm.enable = lib.mkDefault true;
      hyprland.enable = lib.mkDefault true;
    };
  };

  # System-level tools only; user apps go in home-manager.
  environment.systemPackages =
    (with pkgs; [
      # [ CLI Essentials ]
      cloudflare-warp
      direnv
      wget2
      unzip
      curl
      git
      zip
      sd
      # [ ... ]

      # [ Nix ]
      nixd
      nix-du
      # [ ... ]

      # [ Desktop Services ]
      typora
      pamixer
      blueman
      wireplumber
      pavucontrol
      networkmanagerapplet
      qt6Packages.fcitx5-configtool
      # [ ... ]
    ])
    ++ [
      # [ Custom Packages ]
      pkgs.update
      pkgs.init-host
      pkgs.detect-gpu
      pkgs.detect-boot-uuids
      config.boot.loader.limine.package
      # [ ... ]
    ];

  # https://search.nixos.org/options?query=programs.localsend
  programs.localsend = {
    enable = true;
  };

  home-manager.users.${identity.username} = {
    imports = [
      inputs.self.homeModules.apps
      ../../display/bar/waybar
      ../../display/notifications/swaync
      ../../display/osd/swayosd
      ../../display/lock/hyprlock
      ../../display/lock/hypridle
    ];
  };
}
