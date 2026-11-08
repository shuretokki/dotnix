{
  programs.bash = {
    enable = true;
    historyControl = [
      "erasedups"
      "ignoredups"
      "ignorespace"
    ];
    historyIgnore = [
      "ls"
      "cd"
      "exit"
      "clear"
      "pwd"
    ];
    shellOptions = [
      "histappend"
      "extglob"
      "globstar"
      "checkjobs"
      "autocd"
      "cdspell"
      "dirspell"
      "cmdhist"
    ];
    initExtra = ''
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'
    '';
  };

  home.sessionVariables = {
    PAGER = "cat";
    GIT_PAGER = "cat";
    SYSTEMD_PAGER = "cat";
  };
}
