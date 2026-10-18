# AGENTS.md

Guardrails for any agent working in this repo or setting up a machine from
[`DOTFILES.md`](DOTFILES.md). `DOTFILES.md` says *what* the machine should look
like; this file says *how you may get it there*.

## How this repo works

- Each top-level directory is a GNU Stow package mirrored into `$HOME`:
  `zsh/.zshrc` → `~/.zshrc`, `nvim/.config/nvim/` → `~/.config/nvim/`.
- The repo lives at `~/Documents/Projects/dotfiles`, and the symlinks are
  relative to that path.
- `DOTFILES.md` is the single source of truth for the stowed packages and the
  required commands. `scripts/scripts/dotfiles-doctor` parses its
  ```` ```text <name> ```` blocks, so keep those block headers intact.

## Rules

1. **Edit the repo, never the link target.** Change `zsh/.zshrc`, not
   `~/.zshrc`. If a target in `$HOME` is a regular file instead of a symlink,
   that is drift: report it, back it up, and re-stow. Don't edit it in place.
2. **Never append to shell rc files.** Machine-specific lines and installer
   hooks go in `~/.zshrc.local`, which is untracked. Secrets never go in the
   repo.
3. **Back up before overwriting.** Anything in `$HOME` that you move or replace
   goes to `~/.dotfiles-backup/<YYYYmmdd-HHMMSS>/` with its relative path kept.
   Don't create `*.bak*` files next to the original or inside the repo.
4. **Ask before privileged or remote-code steps.** Show the exact command and
   wait for approval before `sudo`, `chsh`, `curl … | sh`, adding a COPR, PPA
   or AUR source, or anything outside `$HOME`.
5. **Stay off Omarchy's layer.** Don't modify `~/.config/hypr`,
   `~/.config/omarchy`, `/usr/share/omarchy`, or Omarchy-managed theme state.
   This repo layers on top of Omarchy.
6. **Keep configs as code.** Don't rewrite Lua, TOML or shell configs as prose,
   and don't generate config from this markdown. Edit the real files.
7. **Verify with the doctor.** Finish every setup or config change with
   `dotfiles-doctor` (or `scripts/scripts/dotfiles-doctor` before `scripts` is
   stowed). Report its output as is. Only call setup done when it shows zero
   failures, and list any warnings you left.
8. **Keep docs in sync.** When you add, remove or rename a package, a required
   tool or a stow package, update `DOTFILES.md` in the same change.

## Conventions

- Code comments, log messages and identifiers are in English.
- Shell: zsh syntax in `zsh/`, bash with `set -uo pipefail` in `scripts/`.
  Guard optional tools with `command -v` so a missing tool never breaks
  shell startup.
- Commits follow Conventional Commits with a scope from the package name, e.g.
  `feat(zsh): …`, `fix(nvim): …`, `docs: …`. See
  `.agents/skills/commit-generator/SKILL.md`. Commits carry no AI or agent
  attribution trailer.
