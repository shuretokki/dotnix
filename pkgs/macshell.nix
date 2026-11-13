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
                                    scale: 0.66
                                    z: 1' \
      --replace-fail 'shadowEnabled: true' 'shadowEnabled: false' \
      --replace-fail '// ── window thumbnail (same box as the icon, so magnification just works) ──' 'Canvas {
                                    id: domCanvas
                                    width: 32
                                    height: 32
                                    visible: false
                                    renderTarget: Canvas.Image
                                    property color dom: Qt.rgba(0.22, 0.22, 0.24, 1)
                                    property string src: img.source.toString()
                                    onSrcChanged: if (src !== "") loadImage(src)
                                    Component.onCompleted: if (src !== "") loadImage(src)
                                    onImageLoaded: requestPaint()
                                    onPaint: {
                                        if (src === "" || !isImageLoaded(src)) return;
                                        var ctx = getContext("2d");
                                        ctx.clearRect(0, 0, 32, 32);
                                        ctx.drawImage(src, 0, 0, 32, 32);
                                        var d = ctx.getImageData(0, 0, 32, 32).data;
                                        var cnt = {};
                                        var best = 0;
                                        var bestKey = "";
                                        for (var i = 0; i < d.length; i += 4) {
                                            if (d[i + 3] < 200) continue;
                                            var key = "" + (d[i] >> 4) + "," + (d[i + 1] >> 4) + "," + (d[i + 2] >> 4);
                                            var e = cnt[key];
                                            if (!e) { e = { n: 0, r: 0, g: 0, b: 0 }; cnt[key] = e; }
                                            e.n++; e.r += d[i]; e.g += d[i + 1]; e.b += d[i + 2];
                                            if (e.n > best) { best = e.n; bestKey = key; }
                                        }
                                        if (best > 0) {
                                            var m = cnt[bestKey];
                                            dom = Qt.rgba(m.r / m.n / 255, m.g / m.n / 255, m.b / m.n / 255, 1);
                                        }
                                    }
                                }
                                Rectangle {
                                    visible: !cell.isSep && !cell.thumbReady
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
  '';

  installPhase = ''
    mkdir -p $out/share/quickshell
    cp -r MacShell MacLock $out/share/quickshell/
    qsb --qt6 -o $out/share/quickshell/MacShell/iconrim.frag.qsb ${./macshell-iconrim.frag}
  '';

  meta = {
    description = "A macOS Tahoe style menu bar, Dock and lock screen for Hyprland, built on Quickshell";
    homepage = "https://github.com/0-ss/MacShell";
    license = lib.licenses.mit;
  };
}
