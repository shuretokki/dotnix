{ inputs, pkgs, ... }:
let
  coucou = inputs.coucou.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      substituteInPlace src-tauri/src/spotify.rs \
        --replace-fail org.mpris.MediaPlayer2.spotify org.mpris.MediaPlayer2.sonora
    '';
  });
in
{
  home.packages = [ coucou ];
}
