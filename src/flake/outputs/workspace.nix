# https://flake.parts/options/flake-parts.html#opt-perSystem
{
  inputs,
  self,
}: {
  config,
  system,
  pkgs,
  ...
}: {
  formatter = pkgs.alejandra;

  # https://github.com/cachix/pre-commit-hooks.nix
  checks.pre-commit = inputs.pre-commit-hooks.lib.${system}.run {
    src = self;
    hooks = {
      statix.enable = true;
      deadnix.enable = true;
    };
  };

  devShells.default = pkgs.mkShell {
    packages = with pkgs; [
      nil
      statix
      deadnix
      alejandra
      nix-doc
      nix-diff
      nix-unit
      nixdoc
      manix
      nvd
      nix-output-monitor
      reviewdog
      dasel
      sops
      age
    ];

    shellHook = ''
      ${config.checks.pre-commit.shellHook or ""}
    '';
  };

  packages = import (self + "/src/pkg") {inherit pkgs;};
}
