{ inputs, ... }:
{
  imports = [
    ./git.nix
    ./shell.nix
    ./starship.nix
    ./eza.nix
    ./bat.nix
    ./fzf.nix
    ./btop.nix
    ./zoxide.nix
    ./direnv.nix
    ./tools.nix
    ./fastfetch.nix
    # From src/lib/home/apps/cli → src/lib/home/programs/gpg
    ../../../home/programs/gpg
  ];
}
