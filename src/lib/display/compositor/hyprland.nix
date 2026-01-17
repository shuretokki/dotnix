# https://wiki.hyprland.org/
# https://search.nixos.org/options?query=programs.hyprland
{
  config,
  pkgs,
  lib,
  inputs,
  identity,
  ...
}: let
  cfg = config.library.display.hyprland;
  hyprland-base = import ./hyprland/base.nix {inherit config pkgs lib;};

  # User overrides from cfg/hyprland/
  userKeybinds = import ../../../../cfg/hyprland/keybinds.nix;
  userEnv = import ../../../../cfg/hyprland/env.nix;
  userRules = import ../../../../cfg/hyprland/rules.nix;

  # Helper: filter out revoked binds, then add new ones
  mergeBinds = default: overrides: let
    revoked = overrides.revoke or [];
    added = overrides.add or [];
    # Filter out any bind where the key combo (first two parts) matches revoked
    filtered =
      builtins.filter (
        bind: let
          parts = lib.splitString "," bind;
        in
          !(builtins.elem (lib.concatStringsSep "," (lib.take 2 parts)) revoked)
      )
      default;
  in
    filtered ++ added;
in {
  options.library.display.hyprland = {
    enable = lib.mkEnableOption "Hyprland Compositor";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    environment.systemPackages = with pkgs;
      [
        swaynotificationcenter
        hyprshot
        swww
        hyprsunset
        playerctl
        vicinae
        libnotify
        apple-cursor
        imagemagick
        matugen
        pulseaudio
        kdePackages.qtwayland
      ]
      ++ hyprland-base.scripts;

    services.power-profiles-daemon.enable = true;

    home-manager.users.${identity.username} = {prefs, ...}: let
      defaultBinds = import ./hyprland/keybinds.nix {inherit pkgs prefs;};
      defaultMouseBinds = import ./hyprland/mkeybinds.nix {inherit pkgs;};
    in {
      wayland.windowManager.hyprland = {
        enable = true;
        plugins = [
          inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
        ];

        settings =
          hyprland-base.settings
          // {
            # Merge default keybinds with user overrides
            bind = mergeBinds defaultBinds userKeybinds.keybinds;
            bindm = mergeBinds defaultMouseBinds userKeybinds.mousebinds;

            # Merge user window/workspace rules
            windowrulev2 = (hyprland-base.settings.windowrulev2 or []) ++ (userRules.windowRules.add or []);
            workspace = (hyprland-base.settings.workspace or []) ++ (userRules.workspaceRules.add or []);

            # Merge user env vars
            env = (hyprland-base.settings.env or []) ++ (userEnv.env.add or []);
          };
      };
    };
  };
}
