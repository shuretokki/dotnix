# https://wiki.nixos.org/wiki/PipeWire
# https://search.nixos.org/options?query=services.pipewire
{
  config,
  lib,
  ...
}: let
  cfg = config.library.core.audio;
in {
  options.library.core.audio = {
    enable = lib.mkEnableOption "PipeWire audio stack";
  };

  config = lib.mkIf cfg.enable {
    # Required for low-latency audio.
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      audio.enable = true;
      socketActivation = true;

      alsa = {
        enable = true;
        # Required for 32-bit apps (games, wine).
        support32Bit = true;
      };

      pulse.enable = true;
      jack.enable = false;
      raopOpenFirewall = false;

      extraConfig = {
        pipewire = {}; # https://gitlab.freedesktop.org/pipewire/pipewire/-/wikis/Config-PipeWire
        client = {}; # https://gitlab.freedesktop.org/pipewire/pipewire/-/wikis/Config-client
        jack = {}; # https://gitlab.freedesktop.org/pipewire/pipewire/-/wikis/Config-JACK
        pipewire-pulse = {}; # https://gitlab.freedesktop.org/pipewire/pipewire/-/wikis/Config-PulseAudio
      };

      wireplumber.enable = true;
    };
  };
}
