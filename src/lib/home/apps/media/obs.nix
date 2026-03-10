# https://wiki.nixos.org/wiki/OBS_Studio
{
  lib,
  pkgs,
  ...
}: {
  programs.obs-studio = {
    enable = lib.mkDefault true;

    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
    ];
  };
}
