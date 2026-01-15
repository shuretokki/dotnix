{
  # NixOS module exports - stable public API
  nixosModules = {
    # Core system modules (grouped)
    core = import ../lib/core;

    # Individual core groups for granular control
    coreSystem = import ../lib/core/system;
    coreHardware = import ../lib/core/hardware;
    coreNetwork = import ../lib/core/network;
    coreSecurity = import ../lib/core/security;

    # Display modules
    display = import ../lib/display;

    # Individual display components (when re-enabled in Phase 3)
    displayLogin = import ../lib/display/login/sddm.nix;
    displayStylex = import ../lib/display/stylix.nix;

    # Profiles
    profiles = import ../lib/profiles;
    profileDesktop = import ../lib/profiles/desktop;
    profileLaptop = import ../lib/profiles/laptop;
    profileServer = import ../lib/profiles/server;
  };

  # Home Manager module exports
  homeModules = {
    # All home modules
    home = import ../lib/home;

    # Individual app categories for granular control
    apps = import ../lib/home/apps;
    appsCli = import ../lib/home/apps/cli;
    appsDev = import ../lib/home/apps/dev;
    appsBrowser = import ../lib/home/apps/browser;
    appsMedia = import ../lib/home/apps/media;
    appsCommunication = import ../lib/home/apps/communication;
    appsTerminal = import ../lib/home/apps/terminal;

    # Global home manager config
    homeGlobal = import ../lib/home/global;
  };
}
