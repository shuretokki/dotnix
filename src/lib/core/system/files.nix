# https://wiki.nixos.org/wiki/GVFS
# https://search.nixos.org/options?query=services.gvfs
# https://search.nixos.org/options?query=xdg.portal
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.library.core.files;
in {
  options.library.core.files = {
    enable = lib.mkEnableOption "File manager integrations";
  };

  config = lib.mkIf cfg.enable {
    services = {
      gnome.sushi.enable = true;
      tumbler.enable = true;
      gvfs.enable = true;
      udisks2.enable = true;
    };

    programs.nautilus-open-any-terminal.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
      config.common.default = "*";
    };
  };
}
