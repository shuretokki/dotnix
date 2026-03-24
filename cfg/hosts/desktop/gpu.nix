# NVIDIA GPU config; open=false uses proprietary driver.
{
  inputs,
  pkgs,
  ...
}: {
  library.core.gpu.nvidia = {
    enable = true;
    open = false;
    package = inputs.nixpkgs-nvidia.legacyPackages.${pkgs.system}.linuxPackages.nvidiaPackages.stable;
  };
}
