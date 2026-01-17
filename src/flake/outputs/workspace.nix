{ inputs, self }: { config, system, pkgs, ... }: {
  formatter = pkgs.nixfmt;

  # Pre-commit hooks for code quality
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
      nixfmt
      statix
      deadnix
    ];

    shellHook = ''
      ${config.checks.pre-commit.shellHook or ""}
    '';
  };

  # Custom packages from src/pkg/
  packages = import (self + "/src/pkg") { inherit pkgs; };
}
