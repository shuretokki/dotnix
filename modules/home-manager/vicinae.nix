{ lib, ... }:
{
  programs.vicinae = {
    enable = true;
    systemd.enable = true;
    settings = {
      search_files_in_root = true;
      launcher_window = {
        opacity = lib.mkForce 0.6;
        rounding = 32;
        material = "none";
        client_side_decorations = {
          border_width = 0;
          shadow_size = 0;
        };
      };
    };
  };
}
