{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  wayland,
  harfbuzz,
  fontconfig,
  freetype,
  libGL,
  libglvnd,
  systemd,
  curl,
  utf8proc,
}:
stdenv.mkDerivation {
  pname = "tide-island";
  version = "0-unstable-2026-11-11";

  src = fetchFromGitHub {
    owner = "enhaoswen";
    repo = "Tide-Island-New";
    rev = "3ce2fbd0f43a1c8114d938151edab307f200fa7d";
    hash = "sha256-aNF3KneJAETYGv4WuFn6O+qv5w596Qwh9LcA2NjFoVA=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    wayland
    harfbuzz
    fontconfig
    freetype
    libGL
    libglvnd
    systemd
    curl
    utf8proc
  ];

  installPhase = ''
    install -Dm755 Tide-island $out/bin/tide-island
  '';

  meta = {
    description = "A Dynamic Island for Wayland drawn with OpenGL";
    homepage = "https://github.com/enhaoswen/Tide-Island-New";
    license = lib.licenses.gpl3Only;
    mainProgram = "tide-island";
  };
}
