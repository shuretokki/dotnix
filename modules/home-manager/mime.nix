{
  config,
  pkgs,
  ...
}:
{
  xdg.mimeApps = {
    enable = true;
    defaultApplicationPackages = [
      pkgs.nautilus
      config.programs.sonora.package
      config.programs.mpv.finalPackage
      pkgs.loupe
      pkgs.papers
    ];
  };
}
