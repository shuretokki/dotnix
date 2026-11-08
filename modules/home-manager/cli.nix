{ pkgs, ... }:
{
  programs = {
    zoxide.enable = true;
    starship.enable = true;
    btop.enable = true;

    direnv = {
      enable = true;
      config.global.warn_timeout = "30s";
    };

    eza = {
      enable = true;
      icons = "auto";
      colors = "auto";
      git = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };

    fzf = {
      enable = true;
      defaultCommand = "fd --type f --hidden --follow --exclude .git";
      defaultOptions = [
        "--height 40%"
        "--layout=reverse"
        "--border"
        "--info=inline"
      ];
      fileWidgetCommand = "fd --type f --hidden --follow --exclude .git";
      fileWidgetOptions = [ "--preview 'head -100 {}'" ];
      changeDirWidgetCommand = "fd --type d --hidden --follow --exclude .git";
      changeDirWidgetOptions = [ "--preview 'eza --tree --level=2 --color=always {} | head -50'" ];
      historyWidgetOptions = [
        "--sort"
        "--exact"
      ];
    };

    bat = {
      enable = true;
      config = {
        style = "numbers,changes,header";
        pager = "less -FR";
        italic-text = "always";
      };
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batgrep
        batwatch
      ];
    };
  };
}
