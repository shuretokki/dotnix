{ pkgs, ... }:
let
  cleanIcon =
    package: id:
    pkgs.runCommand "${id}.svg" { nativeBuildInputs = [ pkgs.librsvg ]; } ''
      rsvg-convert -w 512 -h 512 ${package}/share/icons/hicolor/scalable/apps/${id}.svg -o icon.png
      {
        printf '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 512 512"><image width="512" height="512" xlink:href="data:image/png;base64,'
        base64 -w0 icon.png
        printf '"/></svg>'
      } > $out
    '';

  withCleanIcon =
    package: id:
    pkgs.symlinkJoin {
      inherit (package) name meta;
      paths = [ package ];
      postBuild = ''
        rm $out/share/icons/hicolor/scalable/apps/${id}.svg
        cp ${cleanIcon package id} $out/share/icons/hicolor/scalable/apps/${id}.svg
      '';
    };
in
{
  home.packages = [
    (withCleanIcon pkgs.photocraft "ai.storyteller.photocraft")
    (withCleanIcon pkgs.pdfcraft "ai.storyteller.pdfcraft")
    pkgs.wordcraft
  ];
}
