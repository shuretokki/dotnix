{
  nixosModules = {
    core = import ../lib/core;
    coreSystem = import ../lib/core/system;
    coreHardware = import ../lib/core/hardware;
    coreNetwork = import ../lib/core/network;
    coreSecurity = import ../lib/core/security;

    display = import ../lib/display;
    displayHyprland = import ../lib/display/compositor/hyprland.nix;
    displayLogin = import ../lib/display/login/sddm.nix;
    displayStylix = import ../lib/display/stylix.nix;

    profiles = import ../lib/profiles;
    profileDesktop = import ../lib/profiles/desktop;
    profileLaptop = import ../lib/profiles/laptop;
    profileServer = import ../lib/profiles/server;
  };

  homeModules = {
    home = import ../lib/home;

    apps = import ../lib/home/apps;
    appsCli = import ../lib/home/apps/cli;
    appsDev = import ../lib/home/apps/dev;
    appsBrowser = import ../lib/home/apps/browser;
    appsMedia = import ../lib/home/apps/media;
    appsCommunication = import ../lib/home/apps/communication;
    appsTerminal = import ../lib/home/apps/terminal;

    displayWaybar = import ../lib/display/bar/waybar;
    displaySwaync = import ../lib/display/notifications/swaync;
    displayHyprlock = import ../lib/display/lock/hyprlock;
    displayHypridle = import ../lib/display/lock/hypridle;
    displaySwayosd = import ../lib/display/osd/swayosd;

    homeGlobal = import ../lib/home/global;
  };
}
