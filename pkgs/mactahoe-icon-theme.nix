{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  gtk3,
  hicolor-icon-theme,
}:
stdenvNoCC.mkDerivation {
  pname = "mactahoe-icon-theme";
  version = "2026-09-10";

  src = fetchFromGitHub {
    owner = "vinceliuice";
    repo = "MacTahoe-icon-theme";
    tag = "2026-09-10";
    hash = "sha256-NAahlBOYub0QlqkYStamoCbyWh+H5JG/iFm4Ws9EU3A=";
  };

  nativeBuildInputs = [ gtk3 ];
  propagatedBuildInputs = [ hicolor-icon-theme ];

  dontBuild = true;
  dontDropIconThemeCache = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons
    patchShebangs install.sh
    ./install.sh --dest $out/share/icons --name MacTahoe --theme default
    for theme in $out/share/icons/*; do
      gtk-update-icon-cache --force $theme
    done

    runHook postInstall
  '';

  meta = {
    description = "macOS Tahoe like icon theme for Linux desktops";
    homepage = "https://github.com/vinceliuice/MacTahoe-icon-theme";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
}
