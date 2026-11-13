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
      --replace-fail 'width: 17; height: 17' 'width: 24; height: 24' \
      --replace-fail 'model: root.showTray ? SystemTray.items : null' 'model: root.showTray && ui.trayExpanded ? SystemTray.items : null' \
      --replace-fail '// Bluetooth has its own optional widget; it remains visible when the radio is off.' 'Item {
        visible: root.showTray && SystemTray.items.values.length > 0
        width: visible ? 24 : 0
        height: 28
        Text {
            anchors.centerIn: parent
            text: ui.trayExpanded ? "›" : "‹"
            color: bpal.fg2
            font.pixelSize: 20
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
                                    scale: 0.915
                                    maskEnabled: true
                                    maskSource: tileMask
                                    maskThresholdMin: 0.5
                                    maskSpreadAtMin: 1.0' \
      --replace-fail '// ── window thumbnail (same box as the icon, so magnification just works) ──' 'Item {
                                    id: tileMask
                                    width: img.width
                                    height: img.height
                                    visible: false
                                    layer.enabled: true
                                    Rectangle {
                                        anchors.centerIn: parent
                                        width: parent.width * 0.88
                                        height: width
                                        radius: width * 0.2237
                                        color: "black"
                                    }
                                }
                                Rectangle {
                                    visible: !cell.isSep && !cell.thumbReady
                                    anchors.centerIn: img
                                    width: img.width * 0.805
                                    height: width
                                    radius: width * 0.2237
                                    color: "transparent"
                                    border.width: 1
                                    border.color: Qt.rgba(1, 1, 1, 0.35)
                                }
                                // ── window thumbnail (same box as the icon, so magnification just works) ──'
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
