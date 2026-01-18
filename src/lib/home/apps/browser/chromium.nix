# https://home-manager-options.extranix.com/?query=programs.chromium
{lib, ...}: {
  # extension ids from chrome web store urls.
  programs.chromium = {
    enable = lib.mkDefault true;
    extensions = [
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
      {id = "nngceckbapebfimnlniiiahkandclblb";} # bitwarden
      {id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} # dark reader
    ];
  };
}
