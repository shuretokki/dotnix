{...}: {
  imports = [
    ./cli
    ./dev
    ./browser
    ./media
    ./communication
    ./terminal
    # Shared app modules
    ./files.nix
    ./mime.nix
    ./services.nix
    ./syncthing.nix
    ./vicinae.nix
  ];
}
