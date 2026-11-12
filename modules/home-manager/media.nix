{ pkgs, ... }:
{
  programs.mpv.enable = true;

  home.packages = with pkgs; [
    celluloid
    loupe
    (import ../../pkgs pkgs).cap
  ];
}
