{ config, lib, ... }:
let
  colors = config.lib.stylix.colors;
  names =
    map (n: "base0" + n) [
      "0"
      "1"
      "2"
      "3"
      "4"
      "5"
      "6"
      "7"
      "8"
      "9"
    ]
    ++ map (n: "base0" + n) [
      "A"
      "B"
      "C"
      "D"
      "E"
      "F"
    ];
  block = n: "\\033[48;2;${colors."${n}-rgb-r"};${colors."${n}-rgb-g"};${colors."${n}-rgb-b"}m  ";
  swatch = (lib.concatMapStrings block names) + "\\033[0m";
in
{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos_small";
        padding = {
          top = 1;
          right = 3;
        };
      };
      display = {
        separator = "  ";
        key.width = 11;
        color.keys = "blue";
      };
      modules = [
        "title"
        "separator"
        {
          type = "os";
          key = "OS";
        }
        {
          type = "kernel";
          key = "Kernel";
        }
        {
          type = "uptime";
          key = "Uptime";
        }
        {
          type = "packages";
          key = "Packages";
        }
        {
          type = "shell";
          key = "Shell";
        }
        {
          type = "wm";
          key = "WM";
        }
        {
          type = "terminal";
          key = "Terminal";
        }
        {
          type = "display";
          key = "Display";
        }
        {
          type = "cpu";
          key = "CPU";
        }
        {
          type = "gpu";
          key = "GPU";
        }
        {
          type = "memory";
          key = "Memory";
        }
        {
          type = "disk";
          key = "Disk";
          folders = "/";
        }
        "break"
        {
          type = "theme";
          key = "Theme";
        }
        {
          type = "icons";
          key = "Icons";
        }
        {
          type = "font";
          key = "Font";
        }
        {
          type = "cursor";
          key = "Cursor";
        }
        {
          type = "command";
          key = "Scheme";
          text = "echo ${colors.scheme-name}";
        }
        {
          type = "command";
          key = "Palette";
          text = "printf '${swatch}\\n'";
        }
      ];
    };
  };
}
