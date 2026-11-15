{ lib, pkgs, ... }:
let
  lucideIcons = (import ../../pkgs pkgs).vicinae-lucide-icons;
in
{
  programs.vicinae = {
    enable = true;
    systemd.enable = true;
    package = pkgs.vicinae.overrideAttrs (old: {
      postPatch = (old.postPatch or "") + ''
        # The built-in icons are white SVG files that are compiled into the program.
        # This replaces the ones that have a Lucide twin with the Lucide icon of the same name.
        # Delete this replacement to get the original icons again.
        cp --no-preserve=mode ${lucideIcons}/*.svg src/server/icons/
      '';
    });
    settings = {
      search_files_in_root = true;
      launcher_window = {
        opacity = lib.mkForce 0.6;
        rounding = 32;
        material = "none";
        client_side_decorations = {
          border_width = 0;
          shadow_size = 0;
        };
      };
    };
  };
}
