{ lib, pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "scrapling-mcp";
      runtimeInputs = [
        pkgs.python3
        pkgs.uv
      ];
      runtimeEnv = {
        LD_LIBRARY_PATH = lib.makeLibraryPath [ pkgs.stdenv.cc.cc.lib ];
        UV_PYTHON_DOWNLOADS = "never";
      };
      text = ''
        exec uvx --python python3 --from "scrapling[ai]" scrapling mcp "$@"
      '';
    })
  ];
}
