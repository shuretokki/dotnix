{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation {
  pname = "macshell";
  version = "0.5.1";

  src = fetchFromGitHub {
    owner = "0-ss";
    repo = "MacShell";
    tag = "0.5.1";
    hash = "sha256-sDJ9HtdXYKNrU/VEHgC4olgMzd7MTcIoKn3IeJvXULI=";
  };

  postPatch = ''
    substituteInPlace MacShell/MacBar.qml \
      --replace-fail 'property var trayItem: null' 'property bool trayExpanded: false
                    property var trayItem: null' \
      --replace-fail 'model: root.showTray ? SystemTray.items : null' 'model: root.showTray && ui.trayExpanded ? SystemTray.items : null' \
      --replace-fail '// Bluetooth has its own optional widget; it remains visible when the radio is off.' 'Item {
        visible: root.showTray && SystemTray.items.values.length > 0
        width: visible ? 22 : 0
        height: 28
        Text {
            anchors.centerIn: parent
            text: ui.trayExpanded ? "›" : "‹"
            color: bpal.fg2
            font.pixelSize: 16
        }
        MouseArea {
            anchors.fill: parent
            onClicked: ui.trayExpanded = !ui.trayExpanded
        }
        Timer {
            interval: 10000
            running: ui.trayExpanded
            onTriggered: ui.trayExpanded = false
        }
    }
    // Bluetooth has its own optional widget; it remains visible when the radio is off.'
    substituteInPlace MacShell/MacDock.qml \
      --replace-fail 'visible: !cell.isSep && !cell.thumbReady' 'visible: !cell.isSep && !cell.thumbReady
                                    scale: 0.72
                                    Rectangle {
                                        z: -1
                                        anchors.centerIn: parent
                                        width: parent.width / 0.72
                                        height: width
                                        radius: width * 0.225
                                        color: root.dockDark ? Qt.rgba(0.26, 0.26, 0.28, 0.92) : Qt.rgba(1, 1, 1, 0.92)
                                        border.width: 1
                                        border.color: root.dockDark ? Qt.rgba(1, 1, 1, 0.16) : Qt.rgba(0, 0, 0, 0.12)
                                    }'
  '';

  installPhase = ''
    mkdir -p $out/share/quickshell
    cp -r MacShell MacLock $out/share/quickshell/
  '';

  meta = {
    description = "A macOS Tahoe style menu bar, Dock and lock screen for Hyprland, built on Quickshell";
    homepage = "https://github.com/0-ss/MacShell";
    license = lib.licenses.mit;
  };
}
