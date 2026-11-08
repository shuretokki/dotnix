{
  config,
  inputs,
  pkgs,
  ...
}:
{
  xdg.mimeApps = {
    enable = true;
    defaultApplicationPackages = [
      inputs.hyprfm.packages.${pkgs.stdenv.hostPlatform.system}.default
      config.programs.sonora.package
      config.programs.mpv.finalPackage
      pkgs.loupe
    ];
  };
}
