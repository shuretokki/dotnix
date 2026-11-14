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
  ];

  postPatch = ''
    find . -name "*.orig" -delete
  '';

  installPhase = ''
    mkdir -p $out/share/quickshell
    cp -r MacShell MacLock $out/share/quickshell/
    cp ${./IconClass.qml} $out/share/quickshell/MacShell/IconClass.qml
    qsb --qt6 -o $out/share/quickshell/MacShell/iconrim.frag.qsb ${./iconrim.frag}
    qsb --qt6 -o $out/share/quickshell/MacShell/iconclip.frag.qsb ${./iconclip.frag}
  '';

  meta = {
    description = "A macOS Tahoe style menu bar, Dock and lock screen for Hyprland, built on Quickshell";
    homepage = "https://github.com/0-ss/MacShell";
    license = lib.licenses.mit;
  };
}
