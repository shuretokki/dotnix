{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  sassc,
  glib,
  libxml2,
  bash,
  palette ? {
    bg = "#333333";
    base = "#242424";
    text = "#dadada";
    fg = "#dedede";
    altFg = "#afafaf";
  },
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
    substituteInPlace src/sass/_colors.scss \
      --replace-fail "#ffffff, if(\$darker == 'true', #1f1f1f, #242424)" "#ffffff, if(\$darker == 'true', #1f1f1f, ${palette.base})" \
      --replace-fail "#363636, #dadada" "#363636, ${palette.text}" \
      --replace-fail "#f5f5f5, if(\$darker == 'true', #282828, #333333)" "#f5f5f5, if(\$darker == 'true', #282828, ${palette.bg})" \
      --replace-fail "#f2f2f2, if(\$darker == 'true', #1f1f1f, #242424)" "#f2f2f2, if(\$darker == 'true', #1f1f1f, ${palette.bg})" \
      --replace-fail "#242424, #dedede" "#242424, ${palette.fg}" \
      --replace-fail "#424242, #afafaf" "#424242, ${palette.altFg}" \
      --replace-fail "#ffffff, if(\$darker == 'true', #1e1e1e, #333333)" "#ffffff, if(\$darker == 'true', #1e1e1e, ${palette.bg})" \
      --replace-fail "if(\$darker == 'true', #282828, #333333)" "if(\$darker == 'true', #282828, ${palette.bg})"
    cat >> src/sass/gtk/apps/_libadwaita.scss <<'EOF'

    .sidebar-pane,
    .content-pane .sidebar-pane,
    .sidebar-pane .content-pane {
      &, &:dir(ltr), &:dir(rtl) {
        margin: 0;
        border-radius: 0;
        background-image: none;
        background-color: transparent;
        box-shadow: none;
      }

      &:dir(ltr), &:dir(rtl) {
        banner > revealer > widget { box-shadow: none; }
      }
    }

    window.csd { outline: none; }

    .navigation-sidebar,
    .sidebar-pane list.navigation-sidebar:not(.view) {
      padding: 6px 0 4px;
    }

    .navigation-sidebar > row {
      min-height: 36px;
      padding: 0 8px;
      margin: 0 6px 2px;
      border-radius: 9px;
    }

    .navigation-sidebar > row + row { margin-top: 0; }
    EOF
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
