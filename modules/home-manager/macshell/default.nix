{ pkgs, ... }:
let
  macshell = (import ../../../pkgs pkgs).macshell;

  macshell-start = pkgs.writeShellApplication {
    name = "macshell-start";
    runtimeInputs = with pkgs; [
      quickshell
      awww
      grim
      slurp
      wl-clipboard
      cliphist
      wf-recorder
      hyprpicker
      hyprsunset
      libnotify
      inotify-tools
      zenity
      kdePackages.qtshadertools
    ];
    text = ''
      export QS_ICON_THEME=Papirus-Dark
      while true; do
        qs -c MacShell || true
        sleep 3
      done
    '';
  };
in
{
  home.packages = [
    macshell-start
    pkgs.papirus-icon-theme
    pkgs.quickshell
  ];

  xdg.configFile = {
    "quickshell/MacShell" = {
      source = "${macshell}/share/quickshell/MacShell";
      recursive = true;
    };
    "quickshell/MacLock" = {
      source = "${macshell}/share/quickshell/MacLock";
      recursive = true;
    };
  };

  wayland.windowManager.hyprland.extraLuaFiles.macshell = ./macshell.lua;
}
