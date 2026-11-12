{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  sassc,
  glib,
  libxml2,
  bash,
  dialog,
  ncurses,
  util-linux,
  which,
  file,
}:
stdenvNoCC.mkDerivation {
  pname = "mactahoe-gtk-theme";
  version = "0-unstable-2026-09-28";

  src = fetchFromGitHub {
    owner = "vinceliuice";
    repo = "MacTahoe-gtk-theme";
    rev = "1e45e19f510edb8cde18fa84d6cd5319f60b086b";
    hash = "sha256-6a42HU49N4ChSm4AyW7i6FYAIENZzDogpZzM51muCbg=";
  };

  nativeBuildInputs = [
    sassc
    glib.dev
    libxml2
    bash
    dialog
    ncurses
    util-linux
    which
    file
  ];

  dontBuild = true;

  postPatch = ''
    patchShebangs install.sh parse-sass.sh libs
    substituteInPlace libs/lib-core.sh \
      --replace-fail 'MY_HOME=$(getent passwd "''${MY_USERNAME}" | cut -d: -f6)' 'MY_HOME=/tmp' \
      --replace-fail 'SUDO_BIN="$(command -v sudo)"' 'SUDO_BIN=false'
    substituteInPlace libs/lib-install.sh \
      --replace-fail 'install_app() {' 'install_app() { return 0'
  '';

  installPhase = ''
    runHook preInstall

    export HOME="$TMPDIR"
    mkdir -p "$out/share/themes" "$out/share/mactahoe-firefox"
    ./install.sh --dest "$out/share/themes" --color dark --opacity normal
    cp -r other/firefox/. "$out/share/mactahoe-firefox"

    runHook postInstall
  '';

  meta = {
    description = "macOS Tahoe like theme for GTK desktops";
    homepage = "https://github.com/vinceliuice/MacTahoe-gtk-theme";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
}
