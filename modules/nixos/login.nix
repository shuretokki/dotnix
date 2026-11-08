{ pkgs, ... }:
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "pixie";
    extraPackages = with pkgs.kdePackages; [
      qtdeclarative
      qtsvg
      qt5compat
    ];
    settings.Theme.CursorTheme = "Adwaita";
  };

  environment.systemPackages = [
    (import ../../pkgs pkgs).pixie-sddm
    pkgs.adwaita-icon-theme
  ];
}
