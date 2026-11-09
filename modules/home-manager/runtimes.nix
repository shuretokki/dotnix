{ pkgs, ... }:
{
  programs.uv.enable = true;

  home.packages = [ pkgs.nodejs ];
}
