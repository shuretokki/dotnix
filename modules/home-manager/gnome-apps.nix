{ pkgs, ... }:
{
  home.packages = with pkgs; [
    file-roller
    gnome-calendar
    gnome-contacts
    papers
  ];
}
