{
  # The real-time scheduler lets PipeWire avoid audio crackling under load.
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    # Steam and Wine games use 32-bit audio libraries.
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
