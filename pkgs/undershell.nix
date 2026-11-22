{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  pkg-config,
  python3,
  wayland-scanner,
  cairo,
  curl,
  ffmpeg,
  fontconfig,
  gdk-pixbuf,
  glib,
  libglvnd,
  libxkbcommon,
  lz4,
  nlohmann_json,
  onnxruntime,
  pango,
  pipewire,
  quickjs-ng,
  sqlite,
  systemd,
  tomlplusplus,
  tzdata,
  wayland,
  wayland-protocols,
}:
stdenv.mkDerivation {
  pname = "undershell";
  version = "1.8.0";

  src = fetchFromGitHub {
    owner = "EternalSelf-2328";
    repo = "undershell";
    rev = "v1.8.0";
    hash = "sha256-tsCfs1XSlzOi5qIcD2XDqNeFi2R+/+V35iZDi0Ho/n4=";
  };

  strictDeps = true;
  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    python3
    wayland-scanner
  ];
  buildInputs = [
    cairo
    curl
    ffmpeg
    fontconfig
    gdk-pixbuf
    glib
    libglvnd
    libxkbcommon
    lz4
    nlohmann_json
    onnxruntime
    pango
    pipewire
    quickjs-ng
    sqlite
    systemd
    tomlplusplus
    wayland
    wayland-protocols
  ];

  mesonBuildType = "release";
  mesonFlags = [
    "-Ddev_paths=false"
    "-Dsystemd_user_unit_dir=lib/systemd/user"
    "-Dvideo=enabled"
    "-Ddepth_model=enabled"
    "-Devolution=enabled"
    "-Dscenes=enabled"
    "-Dscripts=enabled"
  ];

  doCheck = true;
  checkPhase = ''
    runHook preCheck
    TZDIR="${tzdata}/share/zoneinfo" \
      meson test --no-rebuild --print-errorlogs config docs editor media motion wallset
    runHook postCheck
  '';

  meta = {
    description = "Wayland desktop widgets, audio visualizers and wallpaper effects";
    homepage = "https://github.com/EternalSelf-2328/undershell";
    license = lib.licenses.gpl3Plus;
    mainProgram = "undershell";
    platforms = lib.platforms.linux;
  };
}
