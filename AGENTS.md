# AGENTS.md

## About This Repo

Dotfiles for macOS. Topic-based organization inspired by Holman's dotfiles. Shell is zsh with znap plugin manager.

## Key Conventions

- **Topic directories** (`git/`, `docker/`, `node/`, etc.) contain related config. All `*.zsh` files in any topic dir are auto-sourced by `zsh/zshrc.symlink`.
- **File naming matters:**
  - `*.symlink` files get symlinked to `~/` by `script/bootstrap` (e.g., `zsh/zshrc.symlink` -> `~/.zshrc`)
  - `path.zsh` loads first (PATH setup), then all other `*.zsh`, then `completion.zsh` loads last (after compinit)
  - `install.sh` in any topic dir is auto-discovered and run by `script/install`
- **Private config** lives outside this repo in `~/.dotfiles-private/` and `~/.localrc`. Never commit secrets here.
- **Functions** in `functions/` are autoloaded via fpath. Prefix completion functions with `_`.
- **Scripts** in `bin/` are on PATH via `system/path.zsh`.

## Workflow

- Restate the goal before starting. Ask clarifying questions if ambiguous.
- List every file you expect to touch. If adding or deleting files, explain why.
- Before modifying any file, search for all references to understand the impact on shell load order.
- State assumptions explicitly before acting on them.
- Match existing patterns: naming, structure, topic organization.
- Prefer reusing existing utilities and abstractions over creating new ones.
- Keep diffs small and focused on a single concern.
- For complex changes, consider edge cases and failure modes before coding.

## Quality Bar

- Before presenting work, ask: "Would a staff engineer approve this in code review?"
- Diff your changes against the base branch mentally — do they make sense as a coherent unit?

## Boundaries

- NEVER run `script/bootstrap`, `script/setup_machine`, or any install scripts unless explicitly asked.
- NEVER run linters or formatters unless explicitly asked.
- NEVER write tests unless explicitly asked.
- NEVER commit secrets or private config to this repo.
