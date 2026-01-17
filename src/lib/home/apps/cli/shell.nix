# https://home-manager-options.extranix.com/?query=programs.bash
# TODO: consider moving wayland auto-start (profileExtra) to display module

{
  lib,
  pkgs,
  prefs,
  ...
}:
{
  home.sessionVariables = {
    PAGER = "cat";
    GIT_PAGER = "cat";
    SYSTEMD_PAGER = "cat";
    DIRENV_LOG_FORMAT = "";
  };

  programs.bash = {
    enable = lib.mkDefault true;
    enableCompletion = true;

    historySize = 10000;
    historyFileSize = 100000;
    historyFile = "$HOME/.bash_history";
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

    sessionVariables = {
      EDITOR = prefs.editor;
      VISUAL = prefs.editor;
    };

    shellAliases = {
      # NixOS rebuild commands (hardcoded dotnix path)
      rebuild = "nh os switch ~/dotnix";
      rebuild-test = "nh os test ~/dotnix";
      rebuild-boot = "nh os boot ~/dotnix";
      rebuild-vm = "nh os build-vm ~/dotnix";

      update = "cd ~/dotnix && nix flake update";
      check = "cd ~/dotnix && nix flake check";
      fmt = "cd ~/dotnix && nix fmt";

      nix-size = "nix path-info -Sh /run/current-system";
      nix-store-size = "du -sh /nix/store";

      generations = "sudo nix-env --list-generations -p /nix/var/nix/profiles/system";
      gen-diff = "nvd diff /run/current-system /nix/var/nix/profiles/system";

      cdsdn = "cd ~/dotnix";
      dev = "nix develop";

      clean = "nh clean all --keep 5";
      why = "nix why-depends";
      search = "nh search";
      vpnstats = "curl https://www.cloudflare.com/cdn-cgi/trace";

      mkdir = "mkdir -pv";
      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -iv";

      gs = "git status";
      gd = "git diff";
      ga = "git add";
      gp = "git push";
      gpl = "git pull";
      gl = "git log --oneline --graph --decorate";
      gcm = "git commit -m";
      gca = "git commit --amend";
      gla = "git log -1 HEAD";
      gco = "git checkout";
      grh = "git reset --hard";
      gb = "git branch";
      gsw = "git switch";
    };

    profileExtra = lib.mkDefault ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec uwsm start hyprland-uwsm.desktop
      fi
    '';

    initExtra = ''
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'

      PROMPT_COMMAND='echo -ne "\033]0;''${USER}@''${HOSTNAME}: ''${PWD}\007"'
    '';

    bashrcExtra = ''
    '';

    logoutExtra = ''
      clear
    '';
  };
}
