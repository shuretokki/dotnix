{
  stdenvNoCC,
  fetchgit,
  noto-fonts,
}:
stdenvNoCC.mkDerivation {
  pname = "qylock-star-rail-sddm";
  version = "0-unstable-2026-11-04";

  src = fetchgit {
    url = "https://github.com/Darkkal44/qylock";
    rev = "c2933f27b655a999911e6699e1b2c67e59cbd428";
    hash = "sha256-ILvDMaTyvNUNg0Ss9f8G4eAb9irCgYFGI1LmytNWncg=";
    sparseCheckout = [ "themes/star-rail" ];
  };

  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -r themes/star-rail $out/share/sddm/themes/star-rail
    mkdir -p $out/share/sddm/themes/star-rail/font
    cp ${noto-fonts}/share/fonts/noto/NotoSans.ttf $out/share/sddm/themes/star-rail/font/
  '';

  meta = {
    description = "Honkai: Star Rail SDDM theme from the qylock collection";
    homepage = "https://github.com/Darkkal44/qylock";
  };
}
