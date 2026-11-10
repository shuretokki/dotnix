{ pkgs, ... }:
{
  programs.uv.enable = true;

  home.packages = [
    pkgs.nodejs
    pkgs.python3
  ];

  home.sessionVariables.UV_PYTHON_DOWNLOADS = "never";
}
