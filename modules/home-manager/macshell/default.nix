{
  config,
  lib,
  pkgs,
  ...
}:
let
  macshell = (import ../../../pkgs pkgs).macshell;
  colors = config.lib.stylix.colors;
  look = {
    darkMode = true;
    appearanceMode = "dark";
    accent = "#${colors.base0D}";
    fontFamily = config.stylix.fonts.sansSerif.name;
    glassOpacity = 0.42;
  };

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
      export QS_ICON_THEME=${config.stylix.icons.dark}
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

  home.activation.macshellSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] (
    lib.concatStrings (
      lib.mapAttrsToList
        (file: values: ''
          settings="$HOME/.config/${file}/settings.json"
          mkdir -p "$(dirname "$settings")"
          [ -f "$settings" ] || echo '{}' > "$settings"
          ${pkgs.jq}/bin/jq '. + ${builtins.toJSON values}' "$settings" > "$settings.tmp"
          mv "$settings.tmp" "$settings"
        '')
        {
          macdock = look // {
            dockEnabled = true;
            desktopIcons = false;
          };
          macbar = look // {
            barStyle = "liquid";
            barGlass = false;
            barBgOpacity = 0.25;
            showTray = false;
          };
        }
    )
  );

  wayland.windowManager.hyprland.extraLuaFiles.macshell = ./macshell.lua;
}
