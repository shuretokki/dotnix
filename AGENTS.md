# Repository guide

This repository holds the NixOS configuration for the host `desktop`.
It is a flake built with flake-parts that follows `nixos-unstable`.
Home Manager follows its `master` branch and runs as a NixOS module.
Stylix will follow it too when it is added.

## Layout

The port is in progress, so some folders do not exist yet.

- `flake.nix` lists the inputs, sets per-system outputs in `perSystem`, and builds each host with `nixosSystem` under `flake`.
- `hosts/<name>/` holds one host: `default.nix` for the system, `home.nix` for the user, and `hardware-configuration.nix`.
- `modules/nixos/` holds system modules, and each file does one job.
- `modules/home-manager/` holds user modules, and each file does one job.
- `modules/home-manager/hyprland/` holds the compositor settings as plain Lua files, which the module loads with `extraLuaFiles`.
- `pkgs/` and `overlays/` hold custom packages and overlays.

## Rules

1. Before you add or change an option, a tool setting, or a task recipe, check the current documentation for that tool and follow its best practice. Some old settings are out of date.
2. Make each desktop part its own module with one enable option. The parts are the compositor, bar, launcher, lock screen, notifications, and theme.
3. Keep colors, fonts, and wallpaper in Stylix only, so that a part can be replaced without touching the palette.
4. Keep nixpkgs, Home Manager, and Stylix on matching branches.
5. If you add a file, run `git add` on it before you build. Flakes ignore files that git does not track.
6. Never print the value of a secret. Secrets use sops-nix, and only encrypted files belong in the repository.
7. Keep every file under `hosts/` and `modules/` a plain NixOS or Home Manager module, and use flake-parts only in `flake.nix` and its flake modules.
8. Do not write original comments. Take each comment from upstream. Find the same line in the nixpkgs installer templates with `mise run upstream <text>`, and copy its comment without changes.
9. If the templates have no comment for a line, read the upstream option description with `mise run option <option>`, or `mise run home-option <option>` for a Home Manager option. Copy it without changes only when it gives a reason or a warning. Otherwise write no comment.
10. A comment must say something the code does not. Never add a comment that restates a setting.
11. Do not put local context in a committed file. That includes hardware names, host names, local paths, personal details, and tools that exist only on one person's computer.
12. After a comment-only edit, strip the comments from the old and new files and check that the code is the same.
13. If something fails, find the real cause first, then research known issues and compare options before you change the machine. Do not loop on retries.
14. Do not set an option to its default value, so that later upstream changes to the default still apply.
15. Keep hardware-specific modules, such as `nvidia.nix`, out of `modules/nixos/default.nix`. The host that needs one imports it by path.
16. Keep `programs.hyprland.withUWSM` at `true`. The cached package is built with it, and `false` forces a local compile of Hyprland.
17. Add a flake input with `nix flake lock`, not `nix flake update`, because `update` moves every input. Make each input follow `nixpkgs`.
18. Check the Lua files under `modules/home-manager/hyprland/` with `lua-language-server --check` against the stubs in the Hyprland package. A wrong name otherwise fails only at login.

## Commands

Run `mise tasks` to list the tasks. The main ones are `fmt`, `check`, `build`, `test`, `switch`, and `update`.

Before each commit, run `mise run fmt`, `mise run check`, and `mise run build`.
A machine that cannot boot this system, such as WSL or CI, can only evaluate and build.
It cannot test boot, the GPU, Hyprland, or secret decryption.
On a low-memory machine, build with fewer `--cores` and `--max-jobs 1`.
On a machine that boots this system, run `mise run test` first, because a reboot undoes it.
Run `mise run switch` only after `test` works.
A new display manager, session, or compositor package takes effect only after a reboot.
For that kind of change, run `mise run boot` and reboot, because `test` leaves the old session running.
Both tasks use `nh`, which shows a diff of the change before it applies it.
On a fresh machine where `nh` is not installed yet, run `sudo nixos-rebuild test --flake .#desktop` once.
If a switch breaks the system, run `sudo nixos-rebuild switch --rollback`.

## Commits

Use Conventional Commits, such as `feat(hyprland): add keybind module`.
Keep each commit to one change, and write the summary in lower case with 72 characters or fewer.
Push only when the owner asks.
