# DOTFILES.md

The desired state of my development machine. A human or an agent should be
able to read this file and set up the computer from it. It describes *what*
the machine should look like and *why*; the configs themselves stay as real
files in this repo, linked into place with GNU Stow.

**Agents:** read [`AGENTS.md`](AGENTS.md) first for the guardrails. Work
through this file top to bottom, and finish by running `dotfiles-doctor`.
Setup is not done until the doctor reports zero failures.

## Target system

- **Primary:** [Omarchy](https://omarchy.org) on Arch Linux, Hyprland, Wayland.
  This is the only system the configs are tested on.
- **Best effort:** Fedora and Ubuntu/Debian. Translate the Arch package names
  below. See [Other distros](#other-distros) for the known differences.

Omarchy owns the desktop layer, and this repo builds on top of it. The zsh
config sources Omarchy's env, aliases and functions from `$OMARCHY_PATH`, and
the Ghostty theme comes from `~/.local/state/omarchy/current/theme/`.

## Packages

Arch package names. Install with `sudo pacman -S --needed <names>`. Anything
already shipped by Omarchy will be skipped.

| Package | Why |
|---|---|
| `zsh` | Login shell. |
| `zsh-autosuggestions`, `zsh-syntax-highlighting` | Sourced by `.zshrc` from `/usr/share/zsh/plugins/`. Install them as system packages; there is no plugin manager. |
| `starship` | Prompt (`starship/.config/starship/starship.toml`). |
| `neovim` | Editor. Must be **>= 0.11**, because the LSP config uses `vim.lsp.config` / `vim.lsp.enable`. |
| `git`, `stow` | Clone this repo and link it into `$HOME`. |
| `ghostty` | Active terminal (first in `~/.config/xdg-terminals.list`). |
| `zed` | Secondary editor (`zeditor`). |
| `fzf`, `fd`, `ripgrep`, `bat`, `eza`, `tree` | `FZF_*` defaults in `.zprofile` use `fd`, `bat` and `eza` for previews. Telescope uses `ripgrep`. |
| `zoxide` | `z` and the `nzo` script. Omarchy's `zd` helper also depends on it. |
| `jq` | Completion for the `omarchy` command in `.zshrc`. |
| `lazygit`, `lazydocker` | `lg` / `lzd` aliases. |
| `mise` | Version manager for runtimes (see below). Omarchy repo ships it as `mise-bin`. |
| `wl-clipboard` | Clipboard for Neovim on Wayland. |
| `ttf-jetbrains-mono-nerd`, `maple-mono-nf-cn-unhinted` (AUR) | Nerd Font glyphs. Ghostty uses Maple Mono. Omarchy ships a JetBrains Mono Nerd variant. |
| `base-devel` | Build toolchain (Treesitter parsers, Mason builds). |

Optional, nice to have: `tldr` (`TEALDEER_CONFIG_DIR` is set), `tobi-try`
(Omarchy repo, lazily initialised `try`), `lstr` (aliased if present).

### Runtimes via mise

Go, Node.js, pnpm and `gh` come from `mise`, not from pacman.
`~/.config/mise/config.toml` is **not tracked in this repo yet**, so recreate
it by hand or copy it from the old machine. `.zshrc` runs `mise activate zsh`.

Neovim installs its own LSP servers and formatters through Mason
(`nvim/.config/nvim/lua/castro/plugins/lsp/mason.lua`). Some Mason packages
need Node.js and Go on `PATH`, so set up `mise` before opening Neovim.

## Clone and link

The repo lives at `~/Documents/Projects/dotfiles`. The symlinks are relative,
so keep it at that path.

```bash
git clone git@github.com:gabrielcastr0/dotfiles.git ~/Documents/Projects/dotfiles
cd ~/Documents/Projects/dotfiles
stow -t ~ --restow nvim zsh starship ghostty zed scripts
```

Packages that must be stowed (read by `dotfiles-doctor`):

```text stow-packages
nvim
zsh
starship
ghostty
zed
scripts
```

`kitty/` is intentionally **not** in the list. Kitty is not installed, and the
package is kept only as a reference for the old themes (decay, eldritch,
oxocarbon).

If stow reports a conflict, an unmanaged file already exists at the target.
Move it to `~/.dotfiles-backup/<timestamp>/`, re-run stow, and then check
whether the old file held anything that should move into the repo or into
`~/.zshrc.local`.

## Post-setup

1. Set the login shell: `chsh -s "$(command -v zsh)"`.
2. Open Neovim to install plugins with lazy.nvim and tools with Mason.
   `lazy-lock.json` is generated locally and is not tracked in this repo.
3. Create `~/.zshrc.local` and, if needed, `~/.zshenv.local` for anything
   machine-specific (see below).
4. Open a new terminal and run `dotfiles-doctor`.

## Local overrides

`.zshrc` sources `~/.zshrc.local` as its last step. That file is not tracked
and holds anything that should not be shared between machines:

- lines that tool installers append, such as the `switch-claude` wrapper;
- hostnames, SSH details, tokens and API keys.

`.zshenv` also sources `~/.zshenv.local` for machine-specific settings needed
by non-interactive shells, such as test worker limits and browser overrides.

Installers that append to `~/.zshrc` turn the stow symlink into a regular
file, and the repo then silently stops applying. When an installer asks to
edit `~/.zshrc`, put its lines in `~/.zshrc.local` instead. `dotfiles-doctor`
flags it when this has happened.

## Not managed here

- `~/.config/hypr`, `~/.config/omarchy`, `~/.config/waybar` and the other
  desktop configs, which belong to Omarchy.
- Agent configuration (`~/.claude`, `~/.codex`), which contains
  employer-specific instructions.
- Secrets of any kind.

## Acceptance criteria

`dotfiles-doctor` (linked to `~/scripts/dotfiles-doctor`, which is on `PATH`)
is read-only and checks the following:

- every file in each `stow-packages` package resolves to the repo;
- every `required-commands` entry is on `PATH`, and the optional ones are
  reported as warnings;
- Neovim is >= 0.11;
- zsh is the login shell and `zsh -i` starts without printing errors;
- the zsh rc files are still symlinks.

```text required-commands
zsh
nvim
git
stow
starship
zoxide
fzf
fd
rg
bat
eza
tree
jq
lazygit
mise
ghostty
wl-copy
```

```text optional-commands
lazydocker
zeditor
gh
go
node
tldr
try
lstr
```

## Map of the configs

| Config | Path | Notes |
|---|---|---|
| zsh | `zsh/.zshenv`, `.zprofile`, `.zshrc`, `.zaliases` | `.zshenv` bootstraps non-interactive shells and loads `.zshenv.local`. `.zprofile` sets `PATH`, editor and FZF. `.zshrc` covers interactive use. `.zaliases` loads after Omarchy's aliases. |
| Neovim | `nvim/.config/nvim/` | lazy.nvim. Plugins are auto-loaded from `lua/castro/plugins/`, and keymaps live in `lua/castro/core/keymaps.lua`. `<leader>ths` opens the theme switcher; `<leader>mk` toggles the mdkite browser preview and `<leader>mr` refreshes it. |
| Starship | `starship/.config/starship/starship.toml` | Palette and modules. |
| Ghostty | `ghostty/.config/ghostty/` | Theme from Omarchy; local `themes/` (rosepine, tokyonight) as fallbacks. |
| Zed | `zed/.config/zed/` | `settings.json` and `keymap.json`. |
| Scripts | `scripts/scripts/` → `~/scripts` | `fzf_listoldfiles.sh` (`nlof`), `zoxide_openfiles_nvim.sh` (`nzo`), `nvim-update` (AppImage updater, non-Arch only), `dotfiles-doctor`, and `fzf-git.sh` (present but not sourced by `.zshrc`). |

## Other distros

Known differences to handle when not on Arch:

- **zsh plugins:** `.zshrc` looks for them in `/usr/share/zsh/plugins/`.
  Ubuntu and Fedora install them under `/usr/share/zsh-autosuggestions/` and
  `/usr/share/zsh-syntax-highlighting/`. Symlink them into the Arch path, or
  the plugins silently don't load.
- **Omarchy:** without it, `$OMARCHY_PATH` is unset and the Omarchy blocks in
  `.zshrc` are skipped. Ghostty will not find its theme file; set
  `config-file = themes/rosepine` instead.
- **Neovim:** the apt version is too old. Use the AppImage in `~/.local/bin`
  and keep it updated with `~/scripts/nvim-update`.
- **Ubuntu/Debian binary names:** `fd` is `fdfind` and `bat` is `batcat`, so
  symlink them into `~/.local/bin`. `eza`, `lazygit` and `starship` need their
  upstream repos or install scripts.
- **Fedora:** `eza` and `lazygit` come from COPR (`alternateved/eza`,
  `atim/lazygit`), and `starship` from its install script.
- **Debian Mason/Python tools:** PEP 668 blocks global pip, so install `pipx`.

## Troubleshooting

- **Neovim plugins broken after an update:** `nvim --headless "+Lazy! restore" +qa`
  restores versions from the local `lazy-lock.json`, if available.
- **LSP not attaching:** `:Mason` and `:checkhealth vim.lsp`.
- **Icons render as boxes:** the terminal is not using a Nerd Font.
