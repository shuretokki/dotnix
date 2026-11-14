{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  makeWrapper,
  libGL,
  libxkbcommon,
  wayland,
  libx11,
  libxcursor,
  libxi,
  libxrandr,
}:
let
  runtimeLibs = [
    libGL
    libxkbcommon
    wayland
    libx11
    libxcursor
    libxi
    libxrandr
  ];
in
rustPlatform.buildRustPackage {
  pname = "explorist";
  version = "0.4.3";

  src = fetchFromGitHub {
    owner = "Rick007110";
    repo = "Explorist";
    rev = "4b6e983c71a7631f2bb9124e6d0fc5b5aff2133a";
    hash = lib.fakeHash;
  };

  cargoHash = lib.fakeHash;

  nativeBuildInputs = [
    pkg-config
    makeWrapper
  ];

  postFixup = ''
    wrapProgram $out/bin/explorist --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath runtimeLibs}
  '';

  meta = {
    description = "A fast, keyboard-first file browser with a Spotlight style search bar";
    homepage = "https://github.com/Rick007110/Explorist";
    license = lib.licenses.gpl3Plus;
    mainProgram = "explorist";
  };
}
