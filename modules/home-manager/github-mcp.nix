{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "github-mcp";
      runtimeInputs = [
        pkgs.gh
        pkgs.github-mcp-server
      ];
      text = ''
        GITHUB_PERSONAL_ACCESS_TOKEN=$(gh auth token)
        export GITHUB_PERSONAL_ACCESS_TOKEN
        exec github-mcp-server stdio "$@"
      '';
    })
  ];
}
