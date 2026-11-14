{ inputs, pkgs, ... }:
let
  coucou = inputs.coucou.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      # The music pill follows one player, named in the bus name org.mpris.MediaPlayer2.spotify.
      # Sonora registers org.mpris.MediaPlayer2.sonora, so the pill never sees it.
      # This swaps the name, so Spotify is no longer followed.
      substituteInPlace src-tauri/src/spotify.rs \
        --replace-fail org.mpris.MediaPlayer2.spotify org.mpris.MediaPlayer2.sonora
    '';
  });
in
{
  home.packages = [ coucou ];
}
