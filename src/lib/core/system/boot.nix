# https://wiki.nixos.org/wiki/Bootloader
# https://search.nixos.org/options?query=boot.loader
{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.boot.dualBoot;
in {
  options.boot.dualBoot = {
    windows = {
      enable = lib.mkEnableOption "Windows Dual Boot";
      uuid = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "UUID of the Windows EFI partition.";
      };
      label = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Filesystem label of the Windows EFI partition.";
      };
    };

    macos = {
      enable = lib.mkEnableOption "MacOS (OpenCore) Dual Boot";
      uuid = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "UUID of the macOS EFI partition.";
      };
      label = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Filesystem label of the macOS EFI partition.";
      };
    };

    extraEntries = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Extra Limine configuration entries.";
    };
  };

  config = {
    boot.loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot.enable = false;
      grub.enable = false;

      # https://search.nixos.org/options?query=boot.loader.limine
      limine = {
        enable = true;

        secureBoot.enable = lib.mkDefault false;
        maxGenerations = lib.mkDefault 10;
        enableEditor = false;

        # Limine doesn't have os-prober; entries are generated from dualBoot config.
        extraEntries = let
          makePrefix = uuid: label:
            if uuid != null
            then "uuid(${lib.toUpper uuid}):"
            else if label != null
            then "label(${label}):"
            else "boot():";

          winPrefix = makePrefix cfg.windows.uuid cfg.windows.label;
          macPrefix = makePrefix cfg.macos.uuid cfg.macos.label;
        in ''
          ${lib.optionalString cfg.windows.enable ''
            /Windows
              protocol: efi_chainload
              path: ${winPrefix}/EFI/Microsoft/Boot/bootmgfw.efi
          ''}
          ${lib.optionalString cfg.macos.enable ''
            /MacOS
              protocol: efi_chainload
              path: ${macPrefix}/EFI/OC/OpenCore.efi
          ''}
          ${cfg.extraEntries}
        '';
      };
    };

    environment.systemPackages = [pkgs.detect-boot-uuids];
  };
}
