let
  ntfs = options: {
    fsType = "ntfs3";
    options = [
      "nofail"
      "uid=1000"
      "gid=100"
      "windows_names"
      "x-systemd.device-timeout=5s"
      "x-gvfs-show"
    ]
    ++ options;
  };
in
{
  fileSystems."/mnt/c" =
    ntfs [
      "ro"
      "x-gvfs-name=C:"
    ]
    // {
      device = "/dev/disk/by-uuid/40DA95A2DA95952E";
    };

  fileSystems."/mnt/d" =
    ntfs [
      "x-gvfs-name=D:"
      "noauto"
      "x-systemd.automount"
    ]
    // {
      device = "/dev/disk/by-uuid/A60A4A3A0A4A07AF";
    };

  fileSystems."/mnt/e" = ntfs [ "x-gvfs-name=E:" ] // {
    device = "/dev/disk/by-uuid/A43A16E73A16B5F0";
  };
}
