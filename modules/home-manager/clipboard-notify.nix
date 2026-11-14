{ pkgs, ... }:
let
  clipboardNotify = pkgs.writeShellApplication {
    name = "clipboard-notify";
    runtimeInputs = with pkgs; [
      coreutils
      gnused
      libnotify
      wl-clipboard
    ];
    text = ''
      types=$(wl-paste --list-types)
      case "$types" in
        *x-kde-passwordManagerHint*) exit 0 ;;
        *image/*) notify-send --app-name Clipboard --icon edit-copy "Image copied" ;;
        *text/*)
          text=$(head -c 600 | tr -s '[:space:]' ' ' | cut -c1-200 | sed 's/&/\&amp;/g; s/</\&lt;/g')
          [ -n "$text" ] && notify-send --app-name Clipboard --icon edit-copy "Copied" "$text"
          ;;
      esac
      exit 0
    '';
  };
in
{
  systemd.user.services.clipboard-notify = {
    Unit = {
      Description = "Notify when something is copied";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${clipboardNotify}/bin/clipboard-notify";
      Restart = "on-failure";
      RestartSec = 3;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
