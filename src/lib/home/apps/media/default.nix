{pkgs, ...}: {
  imports = [
    ./music
    ./obs.nix
    # ./sioyek.nix
  ];

  home.packages = with pkgs; [
    scrcpy
  ];
}
