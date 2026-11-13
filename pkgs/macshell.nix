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
                                    scale: domCanvas.proper ? 0.915 : (domCanvas.square ? 0.805 : 0.66)
                                    z: 1
                                    maskEnabled: domCanvas.square
                                    maskSource: tileMask
                                    maskThresholdMin: 0.5
                                    maskSpreadAtMin: 1.0' \
      --replace-fail 'shadowEnabled: true' 'shadowEnabled: false' \
      --replace-fail '// ── window thumbnail (same box as the icon, so magnification just works) ──' 'Canvas {
                                    id: domCanvas
                                    width: 32
                                    height: 32
                                    visible: false
                                    renderTarget: Canvas.Image
                                    property color dom: Qt.rgba(0.22, 0.22, 0.24, 1)
                                    property bool proper: false
                                    property bool square: false
                                    property string src: img.source.toString()
                                    onSrcChanged: if (src !== "") loadImage(src)
                                    Component.onCompleted: if (src !== "") loadImage(src)
                                    onImageLoaded: requestPaint()
                                    onPaint: {
                                        if (src === "" || !isImageLoaded(src)) return;
                                        var N = 32;
                                        var ctx = getContext("2d");
                                        ctx.clearRect(0, 0, N, N);
                                        ctx.drawImage(src, 0, 0, N, N);
                                        var d = ctx.getImageData(0, 0, N, N).data;
                                        var opaque = 0, x0 = N, x1 = -1, y0 = N, y1 = -1;
                                        for (var y = 0; y < N; y++) {
                                            for (var x = 0; x < N; x++) {
                                                if (d[(y * N + x) * 4 + 3] >= 128) {
                                                    opaque++;
                                                    if (x < x0) x0 = x;
                                                    if (x > x1) x1 = x;
                                                    if (y < y0) y0 = y;
                                                    if (y > y1) y1 = y;
                                                }
                                            }
                                        }
                                        if (opaque === 0) return;
                                        var bw = x1 - x0 + 1, bh = y1 - y0 + 1;
                                        var fill = opaque / (bw * bh);
                                        var corner = Math.max(d[(y0 * N + x0) * 4 + 3], d[(y0 * N + x1) * 4 + 3], d[(y1 * N + x0) * 4 + 3], d[(y1 * N + x1) * 4 + 3]);
                                        var squareish = Math.abs(bw - bh) <= 2;
                                        proper = squareish && fill >= 0.90 && fill <= 0.985 && corner < 100;
                                        square = squareish && fill > 0.985 && corner >= 100 && bw >= 0.9 * N;
                                        var useEdge = fill >= 0.7;
                                        var cnt = {};
                                        var best = 0;
                                        var bestKey = "";
                                        for (var j = 0; j < N; j++) {
                                            for (var i = 0; i < N; i++) {
                                                var p = (j * N + i) * 4;
                                                if (d[p + 3] < 200) continue;
                                                if (useEdge) {
                                                    var edge = i === 0 || j === 0 || i === N - 1 || j === N - 1
                                                        || d[p - 4 + 3] < 128 || d[p + 4 + 3] < 128 || d[p - N * 4 + 3] < 128 || d[p + N * 4 + 3] < 128;
                                                    if (!edge) continue;
                                                }
                                                var key = "" + (d[p] >> 4) + "," + (d[p + 1] >> 4) + "," + (d[p + 2] >> 4);
                                                var e = cnt[key];
                                                if (!e) { e = { n: 0, r: 0, g: 0, b: 0 }; cnt[key] = e; }
                                                e.n++; e.r += d[p]; e.g += d[p + 1]; e.b += d[p + 2];
                                                if (e.n > best) { best = e.n; bestKey = key; }
                                            }
                                        }
                                        if (best > 0) {
                                            var m = cnt[bestKey];
                                            dom = Qt.rgba(m.r / m.n / 255, m.g / m.n / 255, m.b / m.n / 255, 1);
                                        }
                                    }
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
