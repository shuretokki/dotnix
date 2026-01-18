# https://wiki.nixos.org/wiki/Fcitx5
# https://search.nixos.org/options?query=i18n.inputMethod
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.library.core.input;
in {
  options.library.core.input = {
    enable = lib.mkEnableOption "Input method (fcitx5)";
  };

  config = lib.mkIf cfg.enable {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";

      fcitx5 = {
        waylandFrontend = true;

        addons = with pkgs; [
          fcitx5-gtk
          fcitx5-lua
          # fcitx5-rime
          # fcitx5-mozc
          # fcitx5-chinese-addons
        ];
      };
    };

    environment.variables = {
      XMODIFIERS = "@im=fcitx";
    };
  };
}
