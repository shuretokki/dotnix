{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    fd
    ripgrep

    jq
    yq

    tldr

    ncdu
    nix-du

    nh
    nix-output-monitor
    nvd
    nix-tree


    gemini-cli

    inputs.antigravity.packages.${pkgs.system}.default
  ];
}
