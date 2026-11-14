{
  description = "NixOS configuration for the desktop host";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    zapfast = {
      url = "github:crmne/zapfast";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    framr = {
      url = "github:vMohammad24/framr";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    coucou = {
      url = "github:Louis-CFM/coucou";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    marea = {
      url = "github:k4ditano/marea-plm";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.pleamar.inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sonora = {
      url = "github:sonorahq/sonora";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:4evy/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-packages.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    hylki = {
      url = "github:clementpoiret/hylki-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    chillpill-shell = {
      url = "github:LUCKYS1NGHH/ChillPill-Shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.treefmt-nix.flakeModule ];

      systems = [ "x86_64-linux" ];

      perSystem =
        { pkgs, ... }:
        {
          packages = import ./pkgs pkgs;

          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              nixfmt.enable = true;
              deadnix.enable = true;
            };
            settings.global.excludes = [ "hosts/*/hardware-configuration.nix" ];
          };
        };

      flake = {
        overlays = import ./overlays;

        nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/desktop ];
        };
      };
    };
}
