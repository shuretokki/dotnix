# https://www.kernel.org/doc/Documentation/blockdev/zram.txt
_: {
  zramSwap = {
    enable = true;
    memoryPercent = 50;
    memoryMax = 8192;
    priority = 100;
    # algorithm = "zstd";
  };

  # Prevent hanging during rebuild
  # when ZRAM config changes.
  systemd.services."systemd-zram-setup@zram0".stopIfChanged = false;

  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/config/sysctl.nix
  boot.kernel.sysctl = {
    "vm.swappiness" = 180; # 100-200 for ZRAM (faster than disk).
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0; # ZRAM is random-access.
    "vm.max_map_count" = 1048576;
    "fs.inotify.max_user_instances" = 524288;
    "fs.inotify.max_user_watches" = 524288;
  };

  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/system/earlyoom.nix
  services.earlyoom = {
    enable = true;
    freeMemThreshold = 5;
    # freeSwapThreshold = 10;
    # enableNotifications = false;
    # extraArgs = [ "--prefer" "(^|/)(java|chromium)$" ];
    # extraArgs = [ "--avoid" "(^|/)(sshd|tmux)$" ];
  };
}
