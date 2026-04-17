# Chezmoi Migration Plan

This document captures a safe, phased migration from the current Stow-based dotfiles setup to Chezmoi.

## Goals

- Move dotfile management to Chezmoi without breaking current workflows.
- Keep rollback options at every stage.
- Preserve local machine functionality (shell, editor, tmux, package setup) during transition.

## Current State

- Repository currently documents Stow usage.
- Worktree has unrelated in-progress changes; do not mix those with migration commits.
- Target is a branch dedicated to the migration.

## Phase 0: Safety and Baseline

1. Ensure all current work is either committed or stashed.
2. Create a rollback commit/tag before first Chezmoi apply.
3. Keep Stow installed and unchanged until migration parity is confirmed.

Suggested checks:

- `git status`
- `brew bundle check`
- Open a new shell and confirm startup is healthy

## Phase 1: Initialize Chezmoi (No Live Changes Yet)

1. Install and initialize:
   - `brew install chezmoi`
   - `chezmoi init --source "$HOME/dotfiles"`
2. Inspect state only:
   - `chezmoi status`
   - `chezmoi diff`
   - `chezmoi doctor`

Exit criteria:

- Chezmoi initializes successfully and reports expected source state.
- No `apply` has been run yet.

## Phase 2: Import and Model Files

1. Start with low-risk files:
   - `git`, `lsd`, `direnv`
2. Continue with terminal/UI:
   - `alacritty`, `tmux`, `tmuxinator`
3. Migrate shell configs carefully:
   - `zsh`, `fish`
4. Migrate editor and larger configs:
   - `nvim`, then `nix/lmod` if needed
5. Handle bootstrap/system files:
   - `Brewfile`

Use Chezmoi naming conventions for source state, for example:

- `~/.zshrc` -> `dot_zshrc`
- `~/.config/nvim/init.lua` -> `dot_config/nvim/init.lua`

Use `chezmoi add` for files already in `$HOME` to preserve exact content and permissions.

Exit criteria:

- Core files are represented in Chezmoi source format.
- Secrets are not committed in plain text.

## Phase 3: Secrets and Machine-Specific Data

1. Identify sensitive files/values (tokens, API keys, private host settings).
2. Convert sensitive configs to templates where needed.
3. Select and configure a secrets backend (one of):
   - 1Password
   - `pass`
   - `age`
   - GPG
4. Add machine-specific logic using templates and data values (e.g. hostname checks).

Exit criteria:

- No secrets in cleartext in repository history for migration commits.
- Templating behavior works for this machine.

## Phase 4: First Controlled Apply

1. Dry run:
   - `chezmoi apply --dry-run --verbose`
2. Real apply:
   - `chezmoi apply --verbose`
3. Validate in order:
   - Shell startup (`zsh`/`fish`)
   - Git behavior
   - `tmux` and `tmuxinator`
   - `nvim`
   - `brew bundle check`

Rollback plan:

- If critical breakage appears, reset to rollback point and adjust migration incrementally.

Exit criteria:

- Interactive shell and core tools behave as expected after apply.

## Phase 5: Cut Over From Stow

1. Update docs/workflow from Stow commands to Chezmoi commands.
2. Recommended daily workflow:
   - `chezmoi edit <target>`
   - `chezmoi diff`
   - `chezmoi apply`
3. Remove Stow-specific guidance only after multiple successful sessions.

Exit criteria:

- Chezmoi is the default management path.
- Stow is no longer required for routine dotfile updates.

## Phase 6: Hardening and New-Machine Bootstrap

1. Add routine checks:
   - `chezmoi doctor`
   - `chezmoi diff`
2. Add bootstrap instructions for new systems:
   - `sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply <repo>`
3. Optional: add `run_once_` and `run_onchange_` scripts for machine setup tasks.

Exit criteria:

- New machine can be bootstrapped from repository with minimal manual steps.

## Commit Strategy

Keep migration commits focused and small:

1. `chore(chezmoi): add migration plan`
2. `chore(chezmoi): initialize source state`
3. `refactor(dotfiles): migrate low-risk configs`
4. `refactor(dotfiles): migrate shell and editor configs`
5. `docs: switch workflow from stow to chezmoi`

## Definition of Done

- Chezmoi manages all intended dotfiles for this machine.
- Existing workflows (shell, editor, tmux, package checks) pass after apply.
- Documentation reflects Chezmoi as the source of truth.
- Rollback path and bootstrap path are both documented.
