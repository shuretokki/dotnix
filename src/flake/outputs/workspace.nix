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

  # Runs on `nix flake check`
  # https://github.com/cachix/pre-commit-hooks.nix
  checks.pre-commit = inputs.pre-commit-hooks.lib.${system}.run {
    src = self;
    hooks = {
      statix.enable = true;
      deadnix.enable = true;
    };
  };

  # Provides consistent tooling across contributors without global installs.
  devShells.default = pkgs.mkShell {
    packages = with pkgs; [
      nil # https://github.com/oxalica/nil
      statix # https://github.com/oppiliappan/statix
      deadnix # https://github.com/astro/deadnix
      alejandra # https://github.com/kamadorueda/alejandra
      nix-doc
      nix-diff
      nix-unit
      nixdoc
      manix
      nvd
      nix-output-monitor
      reviewdog
      dasel
    ];

    # Auto-installs git hooks on shell entry; no manual setup needed.
    shellHook = ''
      ${config.checks.pre-commit.shellHook or ""}
    '';
  };

  # Separated so custom packages can be built/tested independently of hosts.
  packages = import (self + "/src/pkg") {inherit pkgs;};
}
