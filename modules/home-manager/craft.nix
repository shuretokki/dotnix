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
in
{
  home.packages = with pkgs; [
    photocraft
    pdfcraft
    wordcraft
  ];

  theme.appIcons = {
    "ai.storyteller.pdfcraft" = "${cleanIcon pkgs.pdfcraft "ai.storyteller.pdfcraft"}";
    "ai.storyteller.photocraft" = "${cleanIcon pkgs.photocraft "ai.storyteller.photocraft"}";
  };
}
