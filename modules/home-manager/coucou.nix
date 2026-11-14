{
  config,
  inputs,
  pkgs,
  ...
}:
let
  colors = config.lib.stylix.colors;
  coucou = inputs.coucou.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      # The music pill follows the bus named org.mpris.MediaPlayer2.spotify.
      # Sonora uses its own bus name, so this swaps in org.mpris.MediaPlayer2.sonora.
      # The pill also looks for spotify on the path to count as installed, so this looks for sonora.
      # Delete this replacement to follow Spotify again.
      substituteInPlace src-tauri/src/spotify.rs \
        --replace-fail org.mpris.MediaPlayer2.spotify org.mpris.MediaPlayer2.sonora \
        --replace-fail 'find_on_path("spotify")' 'find_on_path("sonora")'

      # The island is a solid black surface, so the compositor has nothing to blur.
      # This makes it a see-through surface in the window color, and the blur rule in coucou.lua does the rest.
      # Delete this replacement to get the black island again.
      substituteInPlace src/style.css \
        --replace-fail 'background: #000;' 'background: #${colors.base00}8c;'
    '';
  });
in
{
  home.packages = [ coucou ];

  wayland.windowManager.hyprland.extraLuaFiles.coucou = ./coucou.lua;
}
