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
      alejandra
    ];

    shellHook = ''
      ${config.checks.pre-commit.shellHook or ""}
    '';
  };

  packages = import (self + "/src/pkg") {inherit pkgs;};
}
