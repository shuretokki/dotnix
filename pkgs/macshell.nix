{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  qt6,
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

  nativeBuildInputs = [ qt6.qtshadertools ];

  dontWrapQtApps = true;

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
                                    scale: ((domCanvas.proper || domCanvas.square) ? 0.805 : 0.58) / domCanvas.art
                                    z: 1
                                    maskEnabled: domCanvas.square
                                    maskSource: tileMask
                                    maskThresholdMin: 0.5
                                    maskSpreadAtMin: 1.0' \
      --replace-fail 'shadowEnabled: true' 'shadowEnabled: false' \
      --replace-fail '// ── window thumbnail (same box as the icon, so magnification just works) ──' 'IconClass {
                                    id: domCanvas
                                    source: img.source.toString()
                                }
                                Item {
                                    id: tileMask
                                    width: img.width
                                    height: img.height
                                    visible: false
                                    layer.enabled: true
                                    Rectangle {
                                        anchors.fill: parent
                                        radius: width * 0.245
                                        color: "black"
                                    }
                                }
                                Rectangle {
                                    visible: !cell.isSep && !cell.thumbReady && !domCanvas.proper && !domCanvas.square
                                    anchors.centerIn: img
                                    width: img.width * 0.805
                                    height: width
                                    radius: width * 0.245
                                    color: domCanvas.dom
                                    z: 0
                                }
                                ShaderEffect {
                                    visible: !cell.isSep && !cell.thumbReady
                                    anchors.centerIn: img
                                    width: img.width * 0.805
                                    height: width
                                    z: 2
                                    property vector2d itemSize: Qt.vector2d(width, height)
                                    property real cornerR: width * 0.245
                                    fragmentShader: Qt.resolvedUrl("iconrim.frag.qsb")
                                }
                                // ── window thumbnail (same box as the icon, so magnification just works) ──'
    substituteInPlace MacShell/MacBar.qml \
      --replace-fail 'source: root.iconSrc(cell.e.icon)' 'source: ""
                                IconTile {
                                    anchors.fill: parent
                                    source: root.iconSrc(cell.e.icon)
                                }' \
      --replace-fail 'source: rr.ico' 'source: ""
                                IconTile {
                                    anchors.fill: parent
                                    source: rr.ico
                                }'
  '';

  installPhase = ''
    mkdir -p $out/share/quickshell
    cp -r MacShell MacLock $out/share/quickshell/
    qsb --qt6 -o $out/share/quickshell/MacShell/iconrim.frag.qsb ${./macshell-iconrim.frag}
    cp ${./macshell-iconclass.qml} $out/share/quickshell/MacShell/IconClass.qml
    cp ${./macshell-icontile.qml} $out/share/quickshell/MacShell/IconTile.qml
  '';

  meta = {
    description = "A macOS Tahoe style menu bar, Dock and lock screen for Hyprland, built on Quickshell";
    homepage = "https://github.com/0-ss/MacShell";
    license = lib.licenses.mit;
  };
}
