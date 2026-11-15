{ lib, ... }:
{
  programs.vicinae = {
    enable = true;
    systemd.enable = true;
    settings = {
      search_files_in_root = true;
      launcher_window = {
        opacity = lib.mkForce 0.7;
        rounding = 32;
        client_side_decorations.shadow_size = 0;
      };
    };
  };
}
