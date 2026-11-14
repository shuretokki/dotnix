{
  lib,
  stdenvNoCC,
  fetchzip,
  python3,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "nordend-lucide-icons";
  version = "1.73.0";

  src = fetchzip {
    url = "https://registry.npmjs.org/lucide-static/-/lucide-static-${finalAttrs.version}.tgz";
    hash = "sha256-kxFmamI9UoQyGnxUBo2tmRVBt+O0FsR0tnNBxLGewfM=";
  };

  nativeBuildInputs = [ (python3.withPackages (ps: [ ps.fonttools ])) ];

  buildPhase = ''
    runHook preBuild
    python3 ${./build.py} . tabler-icons.ttf
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    install -Dm644 tabler-icons.ttf $out/tabler-icons.ttf
    install -Dm644 LICENSE $out/LICENSE
    runHook postInstall
  '';

  meta = {
    description = "Lucide icons as a font with the glyph names Nordend asks for";
    homepage = "https://lucide.dev";
    license = lib.licenses.isc;
  };
})
