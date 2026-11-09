{ pkgs, ... }:
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

  home.packages = [ pkgs.warp-terminal ];

  home.sessionVariables.TERMINAL = "ghostty";
}
