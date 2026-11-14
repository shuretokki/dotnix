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
    hash = "sha256-+pKOmkllBHqk/pfaLJG71hdo9hm+Tz/lf8jpxpSkbjs=";
  };

  cargoHash = "sha256-HiYjo1Opt+5wbUCH9wamh1XIy5ptLef5RJXEIbhKGIs=";

  # The test reads the home directory, and the build sandbox has none.
  # This skips that one test.
  # Delete this line to run it again.
  checkFlags = [ "--skip=fs::path_input::tests::tilde_is_home" ];

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
