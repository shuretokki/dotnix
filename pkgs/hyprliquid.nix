{
  lib,
  fetchFromGitHub,
  hyprlandPlugins,
  cmake,
  stb,
}:
hyprlandPlugins.mkHyprlandPlugin {
  pluginName = "hyprliquid";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "zaregototsukai";
    repo = "hyprliquid";
    rev = "3130471b3eebe1c2012ea21d3452bf6703f940c1";
    hash = "sha256-c/zXDShNmNzgguvi0fGtrVQrDTyL5Q5K8so6ur7TbWw=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ stb ];
  cmakeFlags = [ "-DCMAKE_BUILD_TYPE=Release" ];

  meta = {
    description = "Liquid Glass, Acrylic, Mica and Aero material effects for Hyprland";
    homepage = "https://github.com/zaregototsukai/hyprliquid";
    license = lib.licenses.bsd3;
  };
}
