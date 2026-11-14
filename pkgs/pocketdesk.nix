{
  lib,
  stdenvNoCC,
  fetchzip,
  autoPatchelfHook,
  makeWrapper,
  stdenv,
  ffmpeg,
  libgbm,
  libglvnd,
  pipewire,
  libx11,
  libxcb,
  libxcursor,
  libxi,
  libxkbcommon,
  libxrandr,
  opus,
  wayland,
  wl-clipboard,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "pocketdesk";
  version = "0.9.0";

  src = fetchzip {
    url = "https://github.com/sreevarshan-xenoz/Pocketdesk/releases/download/v${finalAttrs.version}/pocketdesk-v${finalAttrs.version}-linux-x86_64.tar.gz";
    hash = "sha256-69FvQ+mZikeQQErF+hjKh6SyR9rZx7/dA0agUMueP9Y=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    stdenv.cc.cc.lib
    ffmpeg
    libgbm
    libglvnd
    pipewire
    libx11
    libxcb
    libxcursor
    libxi
    libxkbcommon
    libxrandr
    opus
    wayland
  ];

  runtimeDependencies = [
    libgbm
    libglvnd
    libxkbcommon
    wayland
  ];

  installPhase = ''
    runHook preInstall
    install -Dm755 pocketdesk pocketdesk-app pocketdesk-tray -t $out/bin
    install -Dm755 pocketdesk-pam-ask -t $out/libexec
    install -Dm644 man/pocketdesk.1 -t $out/share/man/man1
    wrapProgram $out/bin/pocketdesk --prefix PATH : ${lib.makeBinPath [ wl-clipboard ]}
    runHook postInstall
  '';

  meta = {
    description = "Your Linux desktop on your Android phone: screen, input, clipboard, files and notifications";
    homepage = "https://github.com/sreevarshan-xenoz/Pocketdesk";
    license = with lib.licenses; [
      mit
      asl20
    ];
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    mainProgram = "pocketdesk";
  };
})
