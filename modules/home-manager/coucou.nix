{ inputs, pkgs, ... }:
let
  coucou = inputs.coucou.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      # The music pill follows the bus named org.mpris.MediaPlayer2.spotify.
      # Sonora uses its own bus name, so this swaps in org.mpris.MediaPlayer2.sonora.
      # Delete this replacement to follow Spotify again.
      substituteInPlace src-tauri/src/spotify.rs \
        --replace-fail org.mpris.MediaPlayer2.spotify org.mpris.MediaPlayer2.sonora
    '';
  });
in
{
  home.packages = [ coucou ];
}
