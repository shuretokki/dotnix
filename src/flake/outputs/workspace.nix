{ repo, alias }: { config, system, pkgs, inputs, ... }: {
  formatter = pkgs.nixfmt-rfc-style;

  # Pre-commit hooks check
  checks.pre-commit = inputs.pre-commit-hooks.lib.${system}.run {
    src = ./../../..;
    hooks = {
      nixfmt-rfc-style.enable = true;
      statix.enable = true;
      deadnix.enable = true;
    };
  };

  devShells.default = pkgs.mkShell {
    packages = with pkgs; [
      nil
      nixfmt-rfc-style
      statix
      deadnix
    ];

    shellHook = ''
      ${config.checks.pre-commit.shellHook}
      echo "${repo} development environment"
    '';
  };

  # Merge custom packages with system builds
  packages =
    let
      pkgs' = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      customPkgs = import ../../../pkgs { pkgs = pkgs'; inherit repo alias; };
      systemPkgs = inputs.nixpkgs.lib.mapAttrs
        (hostname: config: config.config.system.build.toplevel)
        (inputs.nixpkgs.lib.filterAttrs
          (n: v: v.pkgs.system == system)
          (inputs.self.nixosConfigurations or { }));
    in
    customPkgs // systemPkgs;
}
