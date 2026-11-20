{
  lib,
  appimageTools,
  fetchurl,
}:
let
  pname = "millida-launcher";
  version = "2.9.4";

  src = fetchurl {
    url = "https://github.com/millida/launcher/releases/download/v${version}/Millida-Launcher_${version}_amd64.AppImage";
    hash = "sha256-de2t4ZQaa8ukWaVm7+b7GzjJQIUOeLcYgdEWQaLi4B8=";
  };

  contents = appimageTools.extract { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs = pkgs: [ pkgs.libgpg-error ];

  extraInstallCommands = ''
    for desktop in ${contents}/*.desktop; do
      install -Dm644 "$desktop" "$out/share/applications/$(basename "$desktop")"
    done
    if [ -d ${contents}/usr/share/icons ]; then
      cp -r ${contents}/usr/share/icons $out/share/icons
    fi
  '';

  meta = {
    description = "Minecraft launcher with Modrinth and CurseForge mods and automatic Java";
    homepage = "https://github.com/millida/launcher";
    license = lib.licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
    mainProgram = "millida-launcher";
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
}
