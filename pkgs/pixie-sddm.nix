{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation {
  pname = "pixie-sddm";
  version = "3.0";

  src = fetchFromGitHub {
    owner = "xCaptaiN09";
    repo = "pixie-sddm";
    tag = "v3.0";
    hash = "sha256-lmE/49ySuAZDh5xLochWqfSw9qWrIV+fYaK5T2Ckck8=";
  };

  installPhase = ''
    mkdir -p $out/share/sddm/themes/pixie
    cp -r * $out/share/sddm/themes/pixie/
  '';

  meta = {
    description = "Minimal SDDM theme inspired by Google Pixel UI and Material Design 3";
    homepage = "https://github.com/xCaptaiN09/pixie-sddm";
    license = lib.licenses.mit;
  };
}
