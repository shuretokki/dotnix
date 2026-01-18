# NixOS Options Reference

This document contains detailed explanations of NixOS options used in this configuration. These notes were extracted from inline comments to keep the codebase concise while preserving documentation for newcomers.

---

## Core / Hardware

### Audio (PipeWire)

- **`services.pulseaudio.enable = false`**: Disable PulseAudio in favor of PipeWire. PipeWire provides PulseAudio compatibility via `pipewire-pulse`.
- **`security.rtkit.enable`**: Required by PipeWire and PulseAudio for low-latency audio. Allows processes to request real-time scheduling.
- **`services.pipewire.audio.enable`**: Use PipeWire as the primary sound server. Automatically set when alsa, jack, or pulse is enabled.
- **`services.pipewire.socketActivation`**: Start PipeWire when apps connect (socket activation).
- **`services.pipewire.alsa.support32Bit`**: Enable 32-bit ALSA support on 64-bit systems. Required for 32-bit applications (games, wine, etc.).
- **`services.pipewire.pulse.enable`**: PulseAudio server emulation. Allows PulseAudio applications to work with PipeWire.
- **`services.pipewire.jack.enable`**: JACK audio emulation for professional audio applications. Enables low-latency audio for DAWs like Ardour, Bitwig, etc.
- **`services.pipewire.raopOpenFirewall`**: Opens UDP/6001-6002 for RAOP/AirPlay timing and control data.
- **`services.pipewire.extraConfig`**: Additional PipeWire configuration drop-ins. Each item becomes a file in `/etc/pipewire/*.conf.d/`.
- **`services.pipewire.wireplumber`**: WirePlumber session manager (enabled by default).

### Bluetooth

- **`hardware.bluetooth.hsphfpd`**: HSP/HFP headset profile daemon (alternative to PulseAudio's native support). Provides better headset microphone support for some devices.
- **`hardware.bluetooth.disabledPlugins`**: Built-in BlueZ plugins to disable. Example: `[ "sap" ]` to disable SIM Access Profile.
- **`hardware.bluetooth.settings.General.ControllerMode`**: Controller operation mode:
  - `dual`: Classic + Low Energy (default)
  - `bredr`: Classic Bluetooth only
  - `le`: Low Energy only (for BLE devices)
- **`hardware.bluetooth.settings.General.Discoverable`**: Enable device discovery (true/false).
- **`hardware.bluetooth.settings.General.DiscoverableTimeout`**: Discoverable timeout in seconds (0 = always discoverable).
- **`hardware.bluetooth.settings.General.AlwaysPairable`**: Always allow pairing even if not discoverable.
- **`hardware.bluetooth.settings.General.PairableTimeout`**: Pairable timeout in seconds (0 = always pairable).
- **`hardware.bluetooth.settings.General.Experimental`**: Enable experimental features (required for some newer devices).
- **`hardware.bluetooth.settings.Policy.AutoEnable`**: Auto-connect paired devices on startup.
- **`hardware.bluetooth.input.General.ClassicBondedOnly`**: Only allow bonded (paired) devices for classic Bluetooth.
- **`hardware.bluetooth.network.General.DisableSecurity`**: Disable security for network connections (not recommended).
- **`services.blueman.enable`**: Provides a system tray applet and GUI for managing Bluetooth devices.

### Fonts

- **`fonts.fontDir.enable`**: Create a directory with links to all fonts at `/run/current-system/sw/share/X11/fonts`.
- **`fonts.enableDefaultPackages`**: Enable a basic set of default fonts: DejaVu, FreeFont, Gyre, Liberation, Unifont, Noto Color Emoji.
- **`fonts.fontconfig.antialias`**: Enable font antialiasing (smoothing). Default: true.
- **`fonts.fontconfig.hinting`**: Enable font hinting (aligning glyphs to pixel boundaries). Improves rendering at low resolutions.
- **`fonts.fontconfig.hinting.style`**: Hinting style: `"none"`, `"slight"`, `"medium"`, `"full"`.
- **`fonts.fontconfig.subpixel.lcdfilter`**: LCD filter: `"none"`, `"default"`, `"light"`, `"legacy"`.
- **`fonts.fontconfig.subpixel.rgba`**: Subpixel layout: `"none"`, `"rgb"`, `"bgr"`, `"vrgb"`, `"vbgr"`.

### Input (fcitx5)

- **`i18n.inputMethod.type`**: Input method framework: `"ibus"`, `"fcitx5"`, `"nabi"`, `"uim"`, `"hime"`, `"kime"`.
- **`i18n.inputMethod.fcitx5.waylandFrontend`**: Use the Wayland input method frontend. Recommended for Wayland compositors (Hyprland, GNOME, KDE Wayland).
- **`i18n.inputMethod.fcitx5.addons`**: fcitx5 relies on addons for specific input methods and features:
  - `fcitx5-gtk`: GTK+ 2/3/4 IM module (required for GTK apps)
  - `fcitx5-lua`: Lua support (required for some themes/plugins)
  - `fcitx5-rime`: Rime support (Chinese/General)
  - `fcitx5-mozc`: Mozc (Japanese)
  - `fcitx5-chinese-addons`: Chinese Addons (Pinyin, Table, etc.)
- **`environment.variables.XMODIFIERS`**: Force XIM to use fcitx. Often needed for older non-GTK/Qt apps. Note: when `i18n.inputMethod.enable` is true, NixOS automatically sets GTK_IM_MODULE, QT_IM_MODULE, XMODIFIERS.

### Power (TLP)

- **`services.tlp.settings.CPU_SCALING_GOVERNOR_ON_AC/BAT`**: CPU scaling governor.
- **`services.tlp.settings.CPU_BOOST_ON_AC/BAT`**: CPU turbo boost (1 = on, 0 = off).
- **`services.tlp.settings.CPU_ENERGY_PERF_POLICY_ON_AC/BAT`**: CPU energy/performance policy.
- **`services.tlp.settings.DISK_IDLE_SECS_ON_AC/BAT`**: Disk power management (seconds before spin-down).
- **`services.tlp.settings.WIFI_PWR_ON_AC/BAT`**: WiFi power saving.
- **`services.tlp.settings.USB_AUTOSUSPEND`**: USB autosuspend.
- **`services.tlp.settings.RUNTIME_PM_ON_AC/BAT`**: Runtime PM for PCI(e) devices.
- **`services.tlp.settings.START_CHARGE_THRESH_BAT0`**: Battery charge start threshold (if supported).
- **`services.tlp.settings.STOP_CHARGE_THRESH_BAT0`**: Battery charge stop threshold (if supported).
- **`services.power-profiles-daemon.enable`**: Disable power-profiles-daemon (conflicts with TLP).

### GPU / NVIDIA

- **`hardware.nvidia.open`**: Use NVIDIA's open source kernel modules.
  - REQUIRED for RTX 50xx (Blackwell)
  - Recommended for RTX 20xx and newer
  - Set to false for GTX 10xx (Pascal) and older
- **`hardware.nvidia.legacy`**: Legacy driver branches for older GPUs:
  - `"470"`: GTX 600/700/900/10xx series
  - `"390"`: GTX 400/500 series, some 600/700
  - `null`: Use latest stable driver (RTX 20xx+)
- **`hardware.nvidia.prime.mode`**: Optimus/Prime hybrid graphics mode:
  - `"sync"`: NVIDIA always active (best performance, more power)
  - `"offload"`: NVIDIA on-demand (better battery)
- **`hardware.nvidia.modesetting.enable`**: Modesetting is required for Wayland compositors (Hyprland, Sway).
- **`hardware.nvidia.nvidiaSettings`**: nvidia-settings GUI.
- **`hardware.nvidia.powerManagement.finegrained`**: Fine-grained power management (turns off GPU when not in use). Experimental and only works on Turing+ GPUs.
- **`environment.sessionVariables.GBM_BACKEND`**: Force GBM backend for NVIDIA.
- **`environment.sessionVariables.WLR_NO_HARDWARE_CURSORS`**: Hardware cursors can be buggy on NVIDIA.
- **`environment.sessionVariables.__GLX_VENDOR_LIBRARY_NAME`**: Required for Wayland.
- **`environment.sessionVariables.NIXOS_OZONE_WL`**: Enable Wayland for Electron apps.

### GPU / AMD

- **`hardware.graphics.extraPackages`**: Optional packages:
  - `amdvlk`: Official AMD Vulkan (optional, mesa radv is default)
  - `rocmPackages.clr.icd`: OpenCL support
- **`hardware.amdgpu.initrd.enable`**: Load amdgpu in initrd for early KMS. Fixes resolution during boot.
- **`hardware.amdgpu.legacySupport.enable`**: Enable amdgpu for older cards (HD 7000/8000 series). Forces amdgpu instead of radeon driver.
- **`hardware.amdgpu.overdrive.enable`**: Enable overdrive mode for overclocking.
- **`environment.sessionVariables.AMD_VULKAN_ICD`**: Vulkan driver selection:
  - `"RADV"`: mesa radv (recommended for gaming)
  - `"AMDVLK"`: AMD's official Vulkan driver

---

## Core / Network

### NetworkManager

- **`networking.networkmanager.wifi.backend`**: WiFi backend:
  - `"wpa_supplicant"`: Traditional (default)
  - `"iwd"`: Modern Intel alternative (faster, sometimes more reliable)
- **`networking.networkmanager.wifi.scanRandMacAddress`**: Randomize MAC during WiFi scans (privacy).
- **`networking.networkmanager.dhcp`**: DHCP client implementation:
  - `"internal"`: Uses NetworkManager's internal DHCP client (default)
  - `"dhcpcd"`: Uses external dhcpcd
- **`networking.networkmanager.dns`**: DNS resolution method:
  - `"default"`: Update /etc/resolv.conf directly
  - `"systemd-resolved"`: Use systemd-resolved (recommended for modern systems)
  - `"dnsmasq"`: Use dnsmasq for caching
- **`networking.networkmanager.plugins`**: VPN and connection plugins (networkmanager-openvpn, networkmanager-openconnect, etc.).
- **`networking.networkmanager.logLevel`**: Logging verbosity: `"OFF"`, `"ERR"`, `"WARN"`, `"INFO"`, `"DEBUG"`, `"TRACE"`.
- **`networking.networkmanager.unmanaged`**: Interfaces to exclude from NetworkManager management.

### Firewall

- **`networking.firewall.backend`**: Backend: `"iptables"`, `"nftables"`, `"firewalld"`.
- **Common ports**:
  - 22 = SSH
  - 80/443 = HTTP/HTTPS
  - 8080 = dev servers
  - 1714:1764 = KDE Connect
  - 53317 = LocalSend
- **`networking.firewall.trustedInterfaces`**: Interfaces to trust completely (bypass firewall). Example: `[ "tailscale0" ]`.
- **`networking.firewall.allowPing`**: ICMP ping settings.
- **`networking.firewall.pingLimit`**: Rate limit for pings (e.g., `"--limit 1/minute --limit-burst 5"`).
- **`networking.firewall.logRefusedConnections`**: Log refused connections (view with: `dmesg` or `journalctl -k`).
- **`networking.firewall.rejectPackets`**: Reject vs drop:
  - `false`: Silently drop packets (default)
  - `true`: Send ICMP "port unreachable" (faster feedback but easier to scan)

### DNS (dnscrypt-proxy)

- **Server selection**: Quad9 is prioritized for its strong privacy policy and threat intelligence. Mullvad-doh added for redundancy.
- **`sources.public-resolvers`**: Defines the source of resolver lists. Without this, dnscrypt-proxy cannot find any servers to use.
- **`require_dnssec`**: Enforces DNSSEC validation.
- **`require_nolog`**: Ensures resolvers don't log queries.
- **`require_nofilter`**: Ensures resolvers don't filter results.
- **`ipv6_servers`/`block_ipv6`**: Disable IPv6 if it causes binding issues.
- **Blocklist service**: Uses OISD small list (safer, fewer breakages). Timer runs daily with randomized delay.

---

## Core / Security

### Polkit

- **`security.polkit`**: Polkit toolkit assists unprivileged processes to speak to privileged processes. Essential for GUI operations like mounting drives, rebooting, or managing networks.
- **`security.polkit.debug`**: Debug logs (view with: `journalctl -u polkit`).
- **`security.polkit.adminIdentities`**: Admin identities (defaults to wheel group). Defines who can authenticate as an administrator.

### OpenSSH

- **`services.openssh.startWhenNeeded`**: Socket-activated sshd:
  - `true`: systemd starts sshd only when a connection establishes (should save RAM)
  - `false`: sshd runs effectively as a daemon (should lower latency)
- **`services.openssh.allowSFTP`**: Allows using tools like FileZilla, WinSCP, or sshfs.
- **`services.openssh.openFirewall`**: Automatically open port 22 in the firewall.
- **`services.openssh.settings.PasswordAuthentication`**: Disable password authentication to prevent brute-force attacks. You MUST use SSH keys (public/private) to log in.
- **`services.openssh.settings.PermitRootLogin`**: Root login policy:
  - `"yes"`: Allow root login
  - `"no"`: Disable root login entirely
  - `"prohibit-password"`: Allow root login ONLY with keys
- **`services.openssh.settings.KbdInteractiveAuthentication`**: Disable challenge response authentication. Further reduces attack surface by disabling interactive auth methods.
- **`services.openssh.settings.X11Forwarding`**: Enable X11 Forwarding. Allows running GUI applications remotely and displaying them locally. Example: `ssh -X user@host "firefox"`.

### GNOME Keyring

- **`services.gnome.gnome-keyring`**: GNOME Keyring daemon manages user's security credentials (passwords, keys). Used by: NetworkManager (WiFi), VSCode (Sync), Chrome, etc.
- **`security.pam.services.login.enableGnomeKeyring`**: Integrate gnome-keyring with login structure. This unlocks the 'login' keyring automatically when you log in to the system.

### SOPS-nix

Setup:
1. Generate your own age key: `age-keygen -o ~/.config/sops/age/keys.txt`
2. Get your public key: `age-keygen -y ~/.config/sops/age/keys.txt`
3. Update `.sops.yaml` with your public key
4. Create secrets: `sops secrets/secrets.yaml`

---

## Users

### User Groups

Groups grant permissions without sudo:
- **wheel**: sudo access
- **networkmanager**: manage wifi/vpn
- **input**: access input devices (touchpad, tablet)
- **video**: brightness control, GPU access
- **audio**: direct audio device access (usually not needed with PipeWire)

### User Preferences (`_prefs`)

User preferences are consumed by bundlers and affect:
- Git config (name, email)
- Default apps (browser, terminal, editor, file manager)
- Keybinds

---

## Flake Structure

### artifacts.nix vs modules.nix

- **artifacts.nix**: Host-specific outputs (nixosConfigurations, overlays, packages).
- **modules.nix**: Reusable modules that can be imported by external flakes.
- **Why merged?**: Separation of concerns for maintainability. Modules exposed separately so external flakes can import them without our hosts. Merged in flake output to provide a unified interface for `nix flake show`.

### mkHost

- **`identity`**: Centralized to avoid scattering user/host values across multiple files.
- **`utils`**: Avoids repeating builder logic; shared across host and module definitions.
- **Assertions**: Fail fast with clear errors rather than cryptic eval failures.
- **Theme System**: Three-layer design: schema defines options, selection picks preset, preset provides values.

---

## External Links

- [PipeWire Wiki](https://wiki.nixos.org/wiki/PipeWire)
- [Bluetooth Wiki](https://wiki.nixos.org/wiki/Bluetooth)
- [Fonts Wiki](https://wiki.nixos.org/wiki/Fonts)
- [Fcitx5 Wiki](https://wiki.nixos.org/wiki/Fcitx5)
- [TLP Documentation](https://linrunner.de/tlp)
- [Encrypted DNS Wiki](https://wiki.nixos.org/wiki/Encrypted_DNS)
- [NetworkManager Wiki](https://wiki.nixos.org/wiki/NetworkManager)
- [Polkit Wiki](https://wiki.nixos.org/wiki/Polkit)
- [SSH Wiki](https://wiki.nixos.org/wiki/SSH)
- [SOPS-nix](https://github.com/Mic92/sops-nix)
- [NVIDIA NixOS](https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/hardware/video/nvidia.nix)
- [AMD GPU NixOS](https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/hardware/amdgpu.nix)
