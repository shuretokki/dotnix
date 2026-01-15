{ repo, alias, inputs }: { config, system, pkgs, ... }: {
  formatter = pkgs.nixfmt-rfc-style;

  # Pre-commit hooks check (temporarily disabled - will re-enable in next iteration)
  # checks.pre-commit = inputs.pre-commit-hooks.lib.${system}.run {
  #   src = ./../../..;
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

  # TODO: Re-enable in Phase 2 after basic structure works
  # packages = custom packages + system builds
}
