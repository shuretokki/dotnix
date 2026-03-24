# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/hardware/video/nvidia.nix
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/hardware/graphics.nix
{
  config,
  lib,
  ...
}: let
  cfg = config.library.core.gpu.nvidia;

  driverPackage = let
    selectedBranch =
      if cfg.legacy == "390"
      then "legacy_390"
      else if cfg.legacy == "470"
      then "legacy_470"
      else cfg.branch;
  in
    config.boot.kernelPackages.nvidiaPackages.${selectedBranch};
in {
  options.library.core.gpu.nvidia = {
    enable = lib.mkEnableOption "NVIDIA GPU support";

    open = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Use NVIDIA's open source kernel modules.
        REQUIRED for RTX 50xx (Blackwell).
        Recommended for RTX 20xx+. Set false for GTX 10xx and older.
      '';
    };

    legacy = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum ["470" "390"]);
      default = null;
      description = ''
        Legacy driver branch for older GPUs.
        - "470": GTX 600/700/900/10xx
        - "390": GTX 400/500
      '';
    };

    branch = lib.mkOption {
      type = lib.types.enum ["stable" "production" "latest" "beta"];
      default = "stable";
      description = "NVIDIA driver branch to use (ignored if legacy is set).";
    };

    package = lib.mkOption {
      type = lib.types.package;
      default = driverPackage;
      description = "The NVIDIA driver package to use. Overrides branch/legacy.";
    };

    prime = {
      enable = lib.mkEnableOption "Optimus/Prime hybrid graphics for laptops";

      mode = lib.mkOption {
        type = lib.types.enum ["sync" "offload"];
        default = "offload";
        description = ''
          - "sync": NVIDIA always active (performance, more power)
          - "offload": NVIDIA on-demand (better battery)
        '';
      };

      nvidiaBusId = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "PCI bus ID of NVIDIA GPU. Find with: lspci | grep -E 'VGA|3D'";
      };

      intelBusId = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "PCI bus ID of Intel iGPU.";
      };

      amdBusId = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "PCI bus ID of AMD iGPU (for AMD+NVIDIA laptops).";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.xserver.videoDrivers = ["nvidia"];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    hardware.nvidia = {
      # Required for Wayland compositors.
      modesetting.enable = true;
      inherit (cfg) open;
      nvidiaSettings = true;

      powerManagement = {
        enable = false;
        finegrained = false;
      };

      package = cfg.package;

      prime = lib.mkIf cfg.prime.enable (
        if cfg.prime.mode == "sync"
        then {
          sync.enable = true;
          inherit (cfg.prime) nvidiaBusId;
          intelBusId = lib.mkIf (cfg.prime.intelBusId != "") cfg.prime.intelBusId;
          amdgpuBusId = lib.mkIf (cfg.prime.amdBusId != "") cfg.prime.amdBusId;
        }
        else {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
          inherit (cfg.prime) nvidiaBusId;
          intelBusId = lib.mkIf (cfg.prime.intelBusId != "") cfg.prime.intelBusId;
          amdgpuBusId = lib.mkIf (cfg.prime.amdBusId != "") cfg.prime.amdBusId;
        }
      );
    };

    environment.sessionVariables = {
      GBM_BACKEND = "nvidia-drm";
      WLR_NO_HARDWARE_CURSORS = "1";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      NIXOS_OZONE_WL = "1";
    };

    # CUDA support
    # environment.systemPackages = with pkgs; [
    #   cudatoolkit
    #   cudaPackages.cudnn
    # ];
  };
}
