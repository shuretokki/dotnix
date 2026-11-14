{ config, lib, ... }:
let
  cfg = config.theme.appIcons;
  target =
    name: file:
    let
      ext = lib.last (lib.splitString "." (toString file));
    in
    if ext == "svg" then
      "icons/hicolor/scalable/apps/${name}.svg"
    else
      "icons/hicolor/512x512/apps/${name}.${ext}";
in
{
  options.theme.appIcons = lib.mkOption {
    type = lib.types.attrsOf lib.types.path;
    default = { };
    description = "Icon files that replace an application's icon, keyed by the icon name in its desktop entry.";
  };

  config.xdg.dataFile = lib.mapAttrs' (
    name: file: lib.nameValuePair (target name file) { source = file; }
  ) cfg;
}
