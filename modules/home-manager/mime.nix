{
  config,
  pkgs,
  ...
}:
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications."inode/directory" = "nordend.desktop";
    defaultApplicationPackages = [
      config.programs.sonora.package
      pkgs.celluloid
      pkgs.loupe
      pkgs.papers
    ];
  };
}
