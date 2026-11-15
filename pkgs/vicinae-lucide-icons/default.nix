{
  lib,
  stdenvNoCC,
  fetchzip,
  python3,
  vicinae,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "vicinae-lucide-icons";
  version = "1.73.0";

  src = fetchzip {
    url = "https://registry.npmjs.org/lucide-static/-/lucide-static-${finalAttrs.version}.tgz";
    hash = "sha256-kxFmamI9UoQyGnxUBo2tmRVBt+O0FsR0tnNBxLGewfM=";
  };

  nativeBuildInputs = [ python3 ];

  buildPhase = ''
    runHook preBuild
    python3 ${./build.py} . ${vicinae.src}/src/server/icons vicinae-icons
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp vicinae-icons/*.svg $out/
    install -Dm644 LICENSE $out/LICENSE
    runHook postInstall
  '';

  meta = {
    description = "Lucide icons named like the built-in icons of Vicinae";
    homepage = "https://lucide.dev";
    license = lib.licenses.isc;
  };
})
