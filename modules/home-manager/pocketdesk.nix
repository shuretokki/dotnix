{ pkgs, ... }:
let
  pocketdesk = (import ../../pkgs pkgs).pocketdesk;
in
{
  home.packages = [ pocketdesk ];

  systemd.user.services.pocketdesk = {
    Unit = {
      Description = "Pocketdesk server";
      PartOf = [ "graphical-session.target" ];
      After = [
        "graphical-session.target"
        "pipewire.service"
        "wireplumber.service"
      ];
    };
    Service = {
      ExecStart = "${pocketdesk}/bin/pocketdesk start";
      Restart = "on-failure";
      RestartSec = 3;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
