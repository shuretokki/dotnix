{lib, prefs, ...}: {
  imports = [
    ./code.nix
    ./helix.nix
  ];

  home.sessionVariables = {
    EDITOR = lib.mkDefault prefs.editor;
    VISUAL = lib.mkDefault prefs.editor;
  };
}
