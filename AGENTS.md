# AGENTS.md

Guidance for AI agents working in this dotfiles repo.

## Repo layout

- Each top-level directory (except dotfiles like `Brewfile`, `README.md`) is a **stow package**.
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
| `fish` | Primary shell; includes git abbrs, direnv hook, platform paths |
| `git` | `~/.gitconfig` |
| `colima` | Template only — see below |
| `nvim` | LazyVim-based; lua under `.config/nvim/` |
| `direnv`, `alacritty`, `lsd`, `nix`, `tmux`, `tmuxinator`, `vim`, `atuin` | Standard XDG or home-path configs |
| `lmod` | Pixi modulefiles; loaded from fish on Linux HPC |

Use `stow --adopt <pkg>` when a target file already exists and should move into the repo.

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

## Common tasks

- **Add a new stow package:** create `<pkg>/` with home-relative paths, document in README and this file, `stow <pkg>`.
- **Edit Colima defaults:** change `colima/.colima/_templates/default.yaml`; remind user to recreate VM if immutable fields changed.
