{self ? ../..}: {
  # this one brings our custom packages from the 'pkgs' directory
  additions = _final: _prev: import (self + "/src/pkg") {pkgs = _final;};

  # this one contains whatever you want to overlay
  # you can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = _final: _prev: {
    # example: firefox = prev.firefox.override { ... };
  };
}
