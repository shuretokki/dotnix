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
      --replace-fail 'width: 17; height: 17' 'width: 22; height: 22' \
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
                                    maskEnabled: true
                                    maskSource: tileMask
                                    maskThresholdMin: 0.5
                                    maskSpreadAtMin: 1.0
                                    Item {
                                        id: tileMask
                                        anchors.fill: parent
                                        visible: false
                                        layer.enabled: true
                                        Rectangle {
                                            anchors.fill: parent
                                            radius: width * 0.225
                                            color: "black"
                                        }
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
