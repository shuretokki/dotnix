{ pkgs, ... }:
{
  programs.mpv.enable = true;

  home.packages = [ pkgs.loupe ];
}
