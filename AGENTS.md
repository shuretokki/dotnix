# Repository guide

This repository holds the NixOS configuration for the host `desktop`.
It is a flake built with flake-parts that follows `nixos-unstable`.
Home Manager and Stylix follow their `master` branches, and Home Manager runs as a NixOS module.

## Layout

The port is in progress, so some folders do not exist yet.

- `flake.nix` lists the inputs, sets per-system outputs in `perSystem`, and builds each host with `nixosSystem` under `flake`.
- `hosts/<name>/` holds one host, with its `configuration.nix` and `hardware-configuration.nix`.
- `modules/nixos/` holds system modules, and each file does one job.
- `modules/home-manager/` holds user modules, and each file does one job.
- `pkgs/` and `overlays/` hold custom packages and overlays.

## Rules

1. Before you add or change an option, a tool setting, or a task recipe, check the current documentation for that tool and follow its best practice. Some old settings are out of date.
2. Make each desktop part its own module with one enable option. The parts are the compositor, bar, launcher, lock screen, notifications, and theme.
3. Keep colors, fonts, and wallpaper in Stylix only, so that a part can be replaced without touching the palette.
4. Keep nixpkgs, Home Manager, and Stylix on matching branches.
5. If you add a file, run `git add` on it before you build. Flakes ignore files that git does not track.
6. Never print the value of a secret. Secrets use sops-nix, and only encrypted files belong in the repository.
7. Keep every file under `hosts/` and `modules/` a plain NixOS or Home Manager module, and use flake-parts only in `flake.nix` and its flake modules.
8. Write one short comment above a module that says why it exists, and do not repeat what the code shows.
9. If something fails, find the real cause first, then research known issues and compare options before you change the machine. Do not loop on retries.

## Commands

Run `mise tasks` to list the tasks. The main ones are `fmt`, `check`, `build`, `test`, `switch`, and `update`.

Before each commit, run `mise run fmt`, `mise run check`, and `mise run build`.
WSL can evaluate and build the system. It cannot test boot, the GPU, Hyprland, or secret decryption.
On the real machine, run `mise run test` first, because a reboot undoes it.
Run `mise run switch` only after `test` works.
If a switch breaks the system, run `sudo nixos-rebuild switch --rollback`.

## Commits

Use Conventional Commits, such as `feat(hyprland): add keybind module`.
Keep each commit to one change, and write the summary in lower case with 72 characters or fewer.
Push only when the owner asks.
