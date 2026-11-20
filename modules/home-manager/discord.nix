{
  config,
  inputs,
  pkgs,
  ...
}:
let
  serein = inputs.serein.packages.${pkgs.stdenv.hostPlatform.system}.default;
  c = config.lib.stylix.colors.withHashtag;
  palette = {
    colors = {
      base = c.base00;
      sidebar = c.base00;
      chat = c.base00;
      raised = c.base01;
      hover = c.base02;
      selected = c.base02;
      border = c.base02;
      text_strong = c.base07;
      text = c.base05;
      muted = c.base04;
      link = c.base0D;
      accent = c.base0D;
      accent_text = c.base00;
      positive = c.base0B;
      warning = c.base0A;
      danger = c.base08;
      mention_bg = c.base02;
      mention_text = c.base0D;
    };
  };
in
{
  home.packages = [
    (serein.overrideAttrs (old: {
      env = (old.env or { }) // {
        CARGO_PROFILE_RELEASE_DEBUG = "0";
      };
    }))
  ];

  xdg.dataFile."serein/stylix.serein-extension".text = builtins.toJSON {
    manifest = {
      api_version = 1;
      id = "stylix";
      name = "Stylix";
      version = "1.0.0";
      author = "local";
      license = "MIT";
      source = "";
      kind = "theme";
      capabilities = [ ];
      actions = [ ];
    };
    theme = {
      light = palette;
      dark = palette;
    };
    background_image = [ ];
    cover_image = [ ];
    wasm = [ ];
  };
}
