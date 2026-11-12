{
  config,
  lib,
  pkgs,
  ...
}:
let
  colors = config.lib.stylix.colors;
  warp = pkgs.symlinkJoin {
    name = "warp-terminal";
    paths = [ pkgs.warp-terminal ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = "wrapProgram $out/bin/warp-terminal --set WARP_ENABLE_WAYLAND 1 --prefix LD_LIBRARY_PATH : ${
      lib.makeLibraryPath [
        pkgs.wayland
        pkgs.libxkbcommon
      ]
    }";
  };
in
{
  programs.ghostty = {
    enable = true;
    settings = {
      window-padding-x = 10;
      window-padding-y = 10;
      background-opacity = 0.95;
      unfocused-split-opacity = 0.9;
      cursor-style-blink = true;
      mouse-hide-while-typing = true;
      copy-on-select = "clipboard";
      confirm-close-surface = false;
      scrollback-limit = 10000;
    };
  };

  home.packages = [ warp ];

  xdg.dataFile."warp-terminal/themes/stylix.yaml".text = ''
    name: Stylix
    accent: '#${colors.base0D}'
    cursor: '#${colors.base05}'
    background: '#${colors.base00}'
    foreground: '#${colors.base05}'
    details: darker
    terminal_colors:
      bright:
        black: '#${colors.base03}'
        blue: '#${colors.base0D}'
        cyan: '#${colors.base0C}'
        green: '#${colors.base0B}'
        magenta: '#${colors.base0E}'
        red: '#${colors.base08}'
        white: '#${colors.base07}'
        yellow: '#${colors.base0A}'
      normal:
        black: '#${colors.base00}'
        blue: '#${colors.base0D}'
        cyan: '#${colors.base0C}'
        green: '#${colors.base0B}'
        magenta: '#${colors.base0E}'
        red: '#${colors.base08}'
        white: '#${colors.base05}'
        yellow: '#${colors.base0A}'
  '';

  home.sessionVariables.TERMINAL = "warp-terminal";
}
