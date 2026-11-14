{ inputs, pkgs, ... }:
let
  lightpanda = inputs.lightpanda.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  home.packages = [ lightpanda ];

  programs.mcp.servers.lightpanda = {
    command = "lightpanda";
    args = [ "mcp" ];
  };
}
