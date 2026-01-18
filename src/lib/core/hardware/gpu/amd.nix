# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/hardware/amdgpu.nix
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/hardware/graphics.nix
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.library.core.gpu.amd;
in {
  options.library.core.gpu.amd = {
    enable = lib.mkEnableOption "AMD GPU support";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.videoDrivers = ["amdgpu"];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;

      extraPackages = with pkgs; [
        # amdvlk  # Official AMD Vulkan; mesa radv is default.
        rocmPackages.clr.icd
      ];

      extraPackages32 = with pkgs.pkgsi686Linux; [
        # amdvlk
      ];
    };

    hardware.amdgpu = {
      initrd.enable = true;
      legacySupport.enable = false;
      # overdrive.enable = false;
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      AMD_VULKAN_ICD = "RADV";
    };

    # ROCm hip symlink for ml/compute workloads
    # systemd.tmpfiles.rules = [
    #   "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    # ];
  };
}
