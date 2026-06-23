# AGENTS.md

Guidance for AI agents working in this dotfiles repo.

## Repo layout

- Each top-level directory is a **stow package**, except dotfiles like `Brewfile` and `README.md`, and helper directories such as `setup/`.
- Package trees mirror `$HOME` paths. Stow creates symlinks from `~/dotfiles/<pkg>/...` to `~/...`.
- Link with: `cd ~/dotfiles && stow <package>`.

## Conventions

- Match existing style in each config domain (fish, nvim lua, toml, yaml).
- Minimize scope: one package or config area per change when possible.
- Do not commit secrets, tokens, or machine-local runtime state.
- Do not commit changes under `~/.colima/` except the template in `colima/.colima/_templates/default.yaml`.
- Only commit when the user asks.

## Stow packages

| Package | Notes |
|---------|-------|
| `fish` | Primary shell; includes git abbrs, direnv hook, platform paths, `ssh-cluster` for HPC |
| `git` | `~/.gitconfig` |
| `colima` | Template only — see below |
| `nvim` | LazyVim-based; lua under `.config/nvim/` |
| `direnv`, `alacritty`, `lsd`, `nix`, `proxychains`, `tmux`, `tmuxinator`, `vim`, `atuin` | Standard XDG or home-path configs |
| `lmod` | Pixi modulefiles; loaded from fish on Linux HPC |

Use `stow --adopt <pkg>` when a target file already exists and should move into the repo.

## Setup scripts

`setup/` is not a stow package. It contains host setup helpers for machine-level changes that should not be represented as home-directory symlinks.

- `setup/macos.sh`: macOS post-Homebrew setup. It creates `~/.docker/cli-plugins/` and symlinks Homebrew's `docker-compose` binary from `$(brew --prefix)/opt/docker-compose/bin/docker-compose` to `~/.docker/cli-plugins/docker-compose`, enabling Docker CLI Compose plugin discovery.

## Colima

**Version the template, not the active profile.**

- **In repo:** `colima/.colima/_templates/default.yaml`
- **Stow target:** `~/.colima/_templates/default.yaml`
- **Do not stow:** `~/.colima/default/colima.yaml` — Colima rewrites it on start; symlinks cause permission errors ([colima#1004](https://github.com/abiosoft/colima/issues/1004)).

M-series baseline in template: `cpu: 4`, `memory: 8`, `disk: 60`, `vmType: vz`, `mountType: virtiofs`, `rosetta: true`.

After changing cpu/memory/disk/vmType/mountType, the user must recreate the VM:

```bash
colima stop && colima delete && colima start
```

New profiles copy from `_templates/default.yaml` automatically.

## Fish / VITO credentials

`VITO_USERNAME` and `VITO_EMAIL` are set in `fish/.config/fish/config.fish`. **`VITO_PASSWORD` is never stored on the cluster.**

| Host | How `VITO_PASSWORD` is set |
|------|----------------------------|
| macOS | Keychain item `VITO_PASSWORD` for `$USER`, loaded at fish startup via `security find-generic-password` |
| HPC / cluster | Injected per SSH session from the Mac — use `ssh-cluster` (abbr `sshc`), not plain `ssh` |

`ssh-cluster` (`fish/.config/fish/functions/ssh-cluster.fish`) reads Keychain locally and runs `ssh -t` with `export VITO_PASSWORD=…; exec -l $SHELL`. Completions wrap `ssh` (`completions/ssh-cluster.fish`).

**Prerequisites (macOS):** store the password in Keychain once:

```bash
security add-generic-password -a "$USER" -s "VITO_PASSWORD" -w
```

**Limitations:** password exists only for that interactive remote session; plain `ssh`, VS Code Remote-SSH, and `sbatch` jobs do not get it automatically.

## Common tasks

- **Add a new stow package:** create `<pkg>/` with home-relative paths, document in README and this file, `stow <pkg>`.
- **Edit Colima defaults:** change `colima/.colima/_templates/default.yaml`; remind user to recreate VM if immutable fields changed.
