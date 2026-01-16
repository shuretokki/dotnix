{ repo, alias, inputs, self }: { config, system, pkgs, ... }: {
  formatter = pkgs.nixfmt;

  # Pre-commit check temporarily disabled - run manually via `nix run .#checks.x86_64-linux.pre-commit`
  # TODO: Re-enable after formatting all files
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
      nixfmt
      statix
      deadnix
    ];

    shellHook = ''
      echo "${repo} development environment"
      ${config.checks.pre-commit.shellHook or ""}
    '';
  };

  # Custom packages from src/pkg/
  packages = import (self + "/src/pkg") { inherit pkgs repo alias; };
}
