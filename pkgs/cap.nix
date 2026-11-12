{
  lib,
  appimageTools,
  fetchurl,
}:
let
  pname = "cap";
  version = "0.6.3";

  src = fetchurl {
    url = "https://cdn.crabnebula.app/asset/01M768B4NZD7DHVSKG8TFY8QJB";
    name = "Cap_${version}_amd64.AppImage";
    hash = "sha256-+WUYRGz/u8hNiRQ9a0TKF80sMG3xJWVRu+j8WRPiNCA=";
  };

  contents = appimageTools.extract { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    for desktop in ${contents}/*.desktop; do
      install -Dm644 "$desktop" "$out/share/applications/$(basename "$desktop")"
    done
    substituteInPlace $out/share/applications/*.desktop --replace-fail "Exec=Cap" "Exec=cap"
    if [ -d ${contents}/usr/share/icons ]; then
      cp -r ${contents}/usr/share/icons $out/share/icons
    fi
  '';

  meta = {
    description = "Open source screen recorder with instant sharing and a local editor";
    homepage = "https://cap.so";
    license = lib.licenses.agpl3Only;
    platforms = [ "x86_64-linux" ];
    mainProgram = "cap";
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
}
