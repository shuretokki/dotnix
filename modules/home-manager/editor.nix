{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
    ];
    userSettings.telemetry.metrics = false;
  };
}
