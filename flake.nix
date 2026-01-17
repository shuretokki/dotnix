# https://wiki.nixos.org/wiki/Flakes
{
  nixConfig = {
    extra-substituters = [
      "https://shuredotnix.cachix.org"
      "https://hyprland.cachix.org"
      "https://vicinae.cachix.org"
    ];
    extra-trusted-public-keys = [
      "shuredotnix.cachix.org-1:rmlHcxqncZqjzGscGzHhYUctuGc3bQEte7Lh1PkO0Xc="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
    ];
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    flake-parts.url = "github:hercules-ci/flake-parts";
    stylix.url = "github:danth/stylix";
    sops-nix.url = "github:Mic92/sops-nix";
    nixcord.url = "github:kaylorben/nixcord";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    antigravity = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    youtube-music = {
      url = "github:h-banii/youtube-music-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vicinae-extensions = {
      url = "github:vicinaehq/extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    self,
    flake-parts,
    ...
  } @ inputs: let
    identity = import ./cfg/identity.nix;
    utils = import ./src/util {inherit inputs self;};
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import ./src/flake/systems.nix;
      perSystem = import ./src/flake/outputs/workspace.nix {inherit inputs self;};
      flake =
        (import ./src/flake/outputs/artifacts.nix {
          inherit inputs identity utils self;
        })
        // (import ./src/flake/modules.nix);
    };
}
