{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fd
    ripgrep
    jq
    yq
    tldr
    ncdu
    nix-du
    nix-tree
  ];
}
