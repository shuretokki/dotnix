{ lib, pkgs, ... }:
let
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

  home.sessionVariables.TERMINAL = "warp-terminal";
}
