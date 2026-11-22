{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  qt6,
}:
stdenvNoCC.mkDerivation {
  pname = "macshell";
  version = "0.5.3";

  src = fetchFromGitHub {
    owner = "0-ss";
    repo = "MacShell";
    tag = "0.5.3";
    hash = "sha256-iTkJU2LLsUt0vpAs0r9ohwOokiQUZma7QMWYlqO0DgE=";
  };

  nativeBuildInputs = [ qt6.qtshadertools ];

  dontWrapQtApps = true;

  patches = [
    ./patches/tray-chevron.patch
    ./patches/menubar-logo-size.patch
    ./patches/icon-tile.patch
    ./patches/dock-running-apps.patch
    ./patches/notification-sound.patch
    ./patches/settings-toggles.patch
    ./patches/icon-clip-and-rim-setting.patch
    ./patches/icon-scale.patch
    ./patches/settings-layout.patch
    ./patches/menubar-logo-color.patch
    ./patches/bar-tone-file.patch
    ./patches/icon-shape.patch
    ./patches/icon-pixel-snap.patch
    ./patches/icon-edge-setting.patch
    ./patches/icon-settings-tidy.patch
    ./patches/icon-corner-fit.patch
    ./patches/icon-settings-order.patch
    ./patches/tray-chevron-glyph.patch
    ./patches/motion-polish.patch
    ./patches/chevron-morph.patch
    ./patches/tray-no-autoclose.patch
    ./patches/icon-fill-uniform.patch
  ];

  postPatch = ''
    find . -name "*.orig" -delete
  '';

  installPhase = ''
    mkdir -p $out/share/quickshell
    cp -r MacShell MacLock $out/share/quickshell/
    cp ${./IconClass.qml} $out/share/quickshell/MacShell/IconClass.qml
    cp ${./IconTile.qml} $out/share/quickshell/MacShell/IconTile.qml
    qsb --qt6 -o $out/share/quickshell/MacShell/iconrim.frag.qsb ${./iconrim.frag}
    qsb --qt6 -o $out/share/quickshell/MacShell/iconclip.frag.qsb ${./iconclip.frag}
  '';

  meta = {
    description = "A macOS Tahoe style menu bar, Dock and lock screen for Hyprland, built on Quickshell";
    homepage = "https://github.com/0-ss/MacShell";
    license = lib.licenses.mit;
  };
}
