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

      # The island is a solid black surface that hangs under the menu bar.
      # This makes it fully see-through, so the island looks like part of the menu bar.
      # Delete this replacement to get the black island again.
      substituteInPlace src/style.css \
        --replace-fail 'background: #000;' 'background: #${colors.base00}00;'

      # The closed and the active island are 32 px high, and the menu bar is 28 px high.
      # This sets the height to the bar height, so the island does not hang below it.
      # Delete this replacement to get the 32 px island again.
      substituteInPlace src/core/layout.ts \
        --replace-fail 'export const NOTCH_H = 32;' 'export const NOTCH_H = 28;'
    '';
  });
in
{
  home.packages = [ coucou ];

  wayland.windowManager.hyprland.extraLuaFiles.coucou = ./coucou.lua;
}
