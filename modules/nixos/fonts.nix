{ pkgs, ... }:
{
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      fira
      source-han-sans
      source-han-serif
      inter
      eb-garamond
      nerd-fonts.jetbrains-mono
    ];
  };
}
