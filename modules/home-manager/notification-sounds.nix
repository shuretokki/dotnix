{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  sounds = pkgs.runCommand "notification-sounds" { } ''
    mkdir -p $out
    cp ${inputs.coucou}/NotchBuddy/Resources/sounds/approve.wav $out/notification.wav
  '';
in
{
  # The sound belongs to the author of Coucou and may be used to run Coucou for yourself.
  # This copies it at build time, so it stays out of the repository and is never published.
  # Delete this module to get the old silence back.
  xdg.dataFile."sounds/macshell/glass.wav".source = "${sounds}/notification.wav";

  programs.zapfast.settings = lib.mkIf config.programs.zapfast.enable {
    message_sound = "none";
    mention_sound = "none";
  };
}
