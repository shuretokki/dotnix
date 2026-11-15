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
      esac

      sample=$(mktemp)
      trap 'rm -f "$sample"' EXIT
      head -c 600 > "$sample"

      state="''${XDG_RUNTIME_DIR:-/tmp}/clipboard-notify.last"
      key=$(printf '%s' "$types" | cat - "$sample" | sha256sum | cut -d' ' -f1)
      now=$(date +%s)
      if [ -f "$state" ]; then
        read -r old_key old_time < "$state" || true
        if [ "''${old_key:-}" = "$key" ] && [ $((now - ''${old_time:-0})) -le 2 ]; then
          exit 0
        fi
      fi
      echo "$key $now" > "$state"

      case "$types" in
        *image/*) notify-send --app-name "Clipboard Copied" --icon edit-copy "Image" ;;
        *text/*)
          text=$(tr -s '[:space:]' ' ' < "$sample" | cut -c1-200 | sed 's/&/\&amp;/g; s/</\&lt;/g')
          if [ -n "$text" ]; then
            notify-send --app-name "Clipboard Copied" --icon edit-copy "$text"
          fi
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
