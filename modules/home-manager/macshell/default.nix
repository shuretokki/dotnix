{
  lib,
  pkgs,
  ...
}:
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
      export QML2_IMPORT_PATH="${pkgs.qt6.qtmultimedia}/lib/qt-6/qml''${QML2_IMPORT_PATH:+:$QML2_IMPORT_PATH}"
      export QT_PLUGIN_PATH="${pkgs.qt6.qtmultimedia}/lib/qt-6/plugins''${QT_PLUGIN_PATH:+:$QT_PLUGIN_PATH}"
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
    pkgs.awww
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

  home.activation.macshellMenuBarOnly = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    settings="$HOME/.config/macdock/settings.json"
    mkdir -p "$(dirname "$settings")"
    [ -f "$settings" ] || echo '{}' > "$settings"
    ${pkgs.jq}/bin/jq '. + { dockEnabled: false, desktopIcons: false }' "$settings" > "$settings.tmp"
    mv "$settings.tmp" "$settings"
  '';

  wayland.windowManager.hyprland.extraLuaFiles.macshell = ./macshell.lua;
}
