{ repo, alias, inputs, self }: { config, system, pkgs, ... }: {
  formatter = pkgs.nixfmt-rfc-style;

  # Pre-commit hooks check (temporarily disabled - will re-enable in next iteration)
  # checks.pre-commit = inputs.pre-commit-hooks.lib.${system}.run {
  #   src = self;
  #   hooks = {
  #     nixfmt-rfc-style.enable = true;
  #     statix.enable = true;
  #     deadnix.enable = true;
  #   };
  # };

  devShells.default = pkgs.mkShell {
    packages = with pkgs; [
      nil
      nixfmt-rfc-style
      statix
      deadnix
    ];

    shellHook = ''
      echo "${repo} development environment"
    '';
  };

  # Custom packages from src/pkg/
  packages = import (self + "/src/pkg") { inherit pkgs repo alias; };
}
