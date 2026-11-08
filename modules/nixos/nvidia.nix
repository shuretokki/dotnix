{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    # On 64-bit systems, whether to also install 32-bit drivers for 32-bit applications (such as Wine).
    enable32Bit = true;
  };

  # You must configure `hardware.nvidia.open` on NVIDIA driver versions >= 560.
  # It is suggested to use the open source kernel modules on Turing or later GPUs (RTX series, GTX 16xx), and the closed source modules otherwise.
  hardware.nvidia.open = true;
}
