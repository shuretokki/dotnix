{lib, prefs, ...}: {
  imports = [
    ./code.nix
    ./helix.nix
    ./zed.nix
  ];

  home.sessionVariables = {
    EDITOR = lib.mkDefault prefs.editor;
    VISUAL = lib.mkDefault prefs.editor;
  };
}
