# Dotfiles

Personal config managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Setup

From this repo:

```bash
cd ~/dotfiles
stow <package>    # e.g. stow fish
```

Each package mirrors paths under `$HOME`. Example: `stow direnv` links `direnv/.config/direnv/direnv.toml` → `~/.config/direnv/direnv.toml`.

### Packages

| Package | Main targets |
|---------|--------------|
| `alacritty` | `~/.config/alacritty/` |
| `atuin` | `~/config.toml` |
| `colima` | `~/.colima/_templates/default.yaml` |
| `direnv` | `~/.config/direnv/` |
| `fish` | `~/.config/fish/` |
| `git` | `~/.gitconfig` |
| `lmod` | modulefiles under `~/dotfiles/lmod/modules` (used from fish) |
| `lsd` | `~/.config/lsd/config.yml` |
| `nix` | `~/.config/nix/nix.conf` |
| `nvim` | `~/.config/nvim/` |
| `proxychains` | `~/.proxychains/proxychains.conf` |
| `tmux` | `~/.tmux.conf` |
| `tmuxinator` | `~/.config/tmuxinator/` |
| `vim` | `~/.vscodevimrc` |

Stow multiple at once: `stow fish git tmux`.

If a target file already exists, adopt it into the repo first:

```bash
stow --adopt colima
```

## Colima

Template for new Colima profiles (M-series baseline: 4 CPU, 8 GiB RAM, 60 GiB disk, `vz`, `virtiofs`, `rosetta`):

```bash
stow colima
```

- **Template (versioned):** `colima/.colima/_templates/default.yaml` → `~/.colima/_templates/default.yaml`
- **Active profile (not in dotfiles):** `~/.colima/default/colima.yaml` — Colima rewrites this on start, so do not stow it as a symlink.

Edit the template in dotfiles, or run `colima template` after stowing.

To apply template changes to an existing VM (cpu/memory/disk/vmType are fixed at create time):

```bash
colima stop
colima delete
colima start
```

Do not commit runtime state under `~/.colima/` (`_lima/`, sockets, `daemon/`, etc.).
