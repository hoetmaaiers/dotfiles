# Dotfiles

Personal config managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Setup

From this repo:

```bash
cd ~/dotfiles
stow <package>    # e.g. stow fish
```

Each package mirrors paths under `$HOME`. Example: `stow direnv` links `direnv/.config/direnv/direnv.toml` → `~/.config/direnv/direnv.toml`.

On macOS, install Homebrew dependencies first and then run the macOS setup helper:

```bash
brew bundle
./setup/macos.sh
```

`setup/macos.sh` creates `~/.docker/cli-plugins/` and links Homebrew's `docker-compose` binary into Docker's CLI plugin path as `docker-compose`, so `docker compose` can find the Compose plugin.

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

### Helper Scripts

The `setup/` directory is not a stow package. It contains host setup scripts for machine-level steps that do not map cleanly to symlinked dotfiles.

- `setup/macos.sh`: macOS post-Homebrew setup. Requires `brew` and the `docker-compose` formula from `Brewfile`; links the Compose plugin into `~/.docker/cli-plugins/docker-compose`.

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

## Fish

### HPC: `ssh-cluster`

`VITO_PASSWORD` is not stored on the SLURM cluster. On macOS it lives in Keychain; for cluster sessions, inject it per login:

```fish
ssh-cluster mycluster    # or: sshc mycluster
```

Same flags and host completion as `ssh`. Reads Keychain item `VITO_PASSWORD` for `$USER`, exports it on the remote shell for that session only.

Store the password in Keychain once:

```bash
security add-generic-password -a "$USER" -s "VITO_PASSWORD" -w
```

Use plain `ssh` when you do not need `VITO_PASSWORD` on the remote host. Batch jobs (`sbatch`) and VS Code Remote-SSH do not use `ssh-cluster` automatically.
