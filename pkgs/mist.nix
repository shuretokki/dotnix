{
  lib,
  stdenvNoCC,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  sqlite,
  makeWrapper,
  libxkbcommon,
  wayland,
  libdrm,
  libgbm,
  libinput,
  seatd,
  systemd,
  linux-pam,
  libglvnd,
  inter,
  mpv-unwrapped,
  dbus,
  procps,
  libnotify,
  pulseaudio,
  wl-clipboard,
  grim,
  slurp,
  xdg-utils,
  xdg-user-dirs,
}:
let
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "wiktor-jozwiak";
    repo = "mist";
    tag = "v${version}";
    hash = "sha256-Ug0fU+1ALYRsy6e4TsEAlBfFOZYGwcKMGZlb5RzOaO0=";
  };

  native = rustPlatform.buildRustPackage {
    pname = "mist-native";
    inherit version src;
    sourceRoot = "${src.name}/native";
    cargoLock.lockFile = "${src}/native/Cargo.lock";

    postPatch = ''
      rm -f .cargo/config.toml
    '';

    nativeBuildInputs = [ pkg-config ];
    buildInputs = [
      libxkbcommon
      wayland
      libglvnd
      libdrm
      libgbm
      libinput
      seatd
      systemd
      linux-pam
    ];

    doCheck = false;
  };

  mistd = rustPlatform.buildRustPackage {
    pname = "mistd";
    inherit version src;
    sourceRoot = "${src.name}/scripts/mistd";
    cargoLock.lockFile = "${src}/scripts/mistd/Cargo.lock";

    nativeBuildInputs = [ pkg-config ];
    buildInputs = [ sqlite ];

    doCheck = false;
  };

  libraries = [
    wayland
    libxkbcommon
    libglvnd
    libgbm
    libdrm
    libinput
    seatd
    systemd
    linux-pam
    mpv-unwrapped
  ];

  tools = [
    dbus
    procps
    libnotify
    pulseaudio
    wl-clipboard
    grim
    slurp
    xdg-utils
    xdg-user-dirs
    systemd
  ];
in
stdenvNoCC.mkDerivation {
  pname = "mist";
  inherit version src;

  nativeBuildInputs = [ makeWrapper ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    share=$out/share/mist
    install -d $out/bin $share/native $share/scripts $share/shaders $share/examples

    install -Dm755 ${native}/bin/mist-ui $out/bin/mist-ui-bin
    install -Dm755 ${native}/bin/mist-wall $out/bin/mist-wall-bin
    install -Dm755 ${native}/bin/mist-comp $out/bin/mist-comp
    install -Dm755 ${mistd}/bin/mistd $out/bin/mistd
    install -Dm755 native/dist/mist-ui $out/bin/mist-ui
    install -Dm755 native/mist-comp/session/mist-try $out/bin/mist-try

    cp -r native/assets $share/native/
    install -m755 scripts/*.sh $share/scripts/
    cp -r shaders/. $share/shaders/
    cp -r examples/hyprland $share/examples/
    cp -r docs $share/

    install -d $share/fonts
    ln -s ${inter}/share/fonts/truetype/InterVariable.ttf $share/fonts/SF-Pro.ttf
    ln -s $share/native/assets/tabler-icons.ttf $share/fonts/tabler-icons.ttf

    patchShebangs $out/bin/mist-ui $out/bin/mist-try $share/scripts

    for bin in mist-ui-bin mist-wall-bin mist-comp mistd mist-try; do
      wrapProgram $out/bin/$bin \
        --set MIST_DIR $share \
        --set MIST_FONT_DIR $share/fonts \
        --set MIST_TRY_BIN $out/bin \
        --prefix PATH : $out/bin:${lib.makeBinPath tools} \
        --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath libraries}:/run/opengl-driver/lib
    done

    runHook postInstall
  '';

  meta = {
    description = "macOS-inspired desktop shell for Hyprland, written in Rust and drawn on the CPU";
    homepage = "https://github.com/wiktor-jozwiak/mist";
    changelog = "https://github.com/wiktor-jozwiak/mist/releases/tag/v${version}";
    license = lib.licenses.gpl3Only;
    mainProgram = "mist-try";
    platforms = [ "x86_64-linux" ];
  };
}
