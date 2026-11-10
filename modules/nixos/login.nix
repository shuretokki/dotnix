{ pkgs, ... }:
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "star-rail";
    extraPackages = with pkgs.kdePackages; [
      qtdeclarative
      qtsvg
      qt5compat
      qtmultimedia
    ];
    settings.Theme.CursorTheme = "Adwaita";
  };

  environment.systemPackages = [
    (import ../../pkgs pkgs).qylock-sddm
    pkgs.adwaita-icon-theme
  ];
}
