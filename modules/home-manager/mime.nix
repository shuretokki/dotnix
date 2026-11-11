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
      pkgs.celluloid
      pkgs.loupe
      pkgs.papers
    ];
  };
}
