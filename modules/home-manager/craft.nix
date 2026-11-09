{ pkgs, ... }:
{
  home.packages = with pkgs; [
    photocraft
    pdfcraft
    wordcraft
  ];
}
