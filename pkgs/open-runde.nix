{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation {
  pname = "open-runde";
  version = "0-unstable-2024-01-18";

  src = fetchFromGitHub {
    owner = "lauridskern";
    repo = "open-runde";
    rev = "3e7ed7f3cdfa5523766db7e430066472615fc935";
    hash = "sha256-eN8neKFohuVyO17B2UAW+GmnSIny05qSiPKdEAsobCs=";
  };

  installPhase = ''
    install -Dm444 -t $out/share/fonts/opentype src/desktop/*.otf
    install -Dm444 -t $out/share/doc/open-runde LICENSE.txt
  '';

  meta = {
    description = "Rounded variant of the Inter typeface";
    homepage = "https://github.com/lauridskern/open-runde";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
  };
}
