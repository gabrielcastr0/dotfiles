# Dotfiles

Personal Linux development environment for Omarchy on Arch Linux, managed with GNU Stow.

<p align="center">
  <a href="https://omarchy.org/"><picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://shieldcn.dev/badge/Platform-Omarchy-555555.svg?logo=archlinux&amp;variant=secondary&amp;mode=dark">
    <img alt="Platform: Omarchy" src="https://shieldcn.dev/badge/Platform-Omarchy-555555.svg?logo=archlinux&amp;variant=secondary&amp;mode=light">
  </picture></a>
  <a href="https://www.gnu.org/software/stow/"><picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://shieldcn.dev/badge/Managed%20with-GNU%20Stow-555555.svg?logo=gnu&amp;variant=secondary&amp;mode=dark">
    <img alt="Managed with GNU Stow" src="https://shieldcn.dev/badge/Managed%20with-GNU%20Stow-555555.svg?logo=gnu&amp;variant=secondary&amp;mode=light">
  </picture></a>
  <a href="LICENSE"><picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://shieldcn.dev/github/gabrielcastr0/dotfiles/license.svg?variant=secondary&amp;mode=dark">
    <img alt="License: GNU GPL v3" src="https://shieldcn.dev/github/gabrielcastr0/dotfiles/license.svg?variant=secondary&amp;mode=light">
  </picture></a>
</p>

## What's included

Each directory below is a Stow package. Stow symlinks its files into the
matching locations under your home directory. Omarchy manages the desktop and
provides the active Ghostty theme.

| Package | What's inside |
| --- | --- |
| [`zsh/`](zsh/) | Vi-mode editing, shell completions, and integrations with fzf, zoxide, mise, and Starship. |
| [`nvim/`](nvim/.config/nvim/) | Lua configuration with plugin revisions pinned by lazy.nvim, language tooling through Mason, and Markdown preview in the browser. |
| [`starship/`](starship/.config/starship/starship.toml) | A two-line Catppuccin Mocha prompt with Git status. |
| [`ghostty/`](ghostty/.config/ghostty/) | Personal terminal settings, keyboard shortcuts for tabs and splits, and bundled Rose Pine and Tokyo Night palettes. |
| [`scripts/`](scripts/scripts/) | File pickers for Neovim, a setup checker, and a Neovim AppImage updater for non-Arch systems. |

## Getting started

The setup is tested on Omarchy. See the [notes for Fedora and Ubuntu/Debian](DOTFILES.md#other-distros)
if you use another distribution.

1. Install the [required packages](DOTFILES.md#packages), including Git, GNU Stow,
   and Neovim 0.12 or newer. Set up any missing [runtimes](DOTFILES.md#runtimes-via-mise)
   before launching Neovim.
2. Clone the repository and preview the symlinks.

   ```sh
   git clone https://github.com/gabrielcastr0/dotfiles.git ~/Documents/Projects/dotfiles
   cd ~/Documents/Projects/dotfiles
   stow -n -v -t ~ nvim zsh starship ghostty scripts
   ```

3. Follow the [backup instructions](DOTFILES.md#clone-and-link) for any existing
   configs that conflict with Stow, then apply the symlinks.

   ```sh
   stow -t ~ nvim zsh starship ghostty scripts
   ```

4. Add the [Ghostty config include](DOTFILES.md#ghostty-entry-config) and follow the
   [post-setup steps](DOTFILES.md#post-setup) for zsh and Neovim. In a new terminal,
   run the read-only checker to verify symlinks, required tools, and shell startup.

   ```sh
   dotfiles-doctor
   ```

Keep machine-specific shell settings in [`~/.zshrc.local` or `~/.zshenv.local`](DOTFILES.md#local-overrides).
For agent-assisted setup, start with [`AGENTS.md`](AGENTS.md) and [`DOTFILES.md`](DOTFILES.md).

## Usage

| Command or shortcut | Action |
| --- | --- |
| `nlof` in zsh | Pick a recently opened Neovim file with fzf. |
| `nzo` in zsh | Pick a directory from zoxide history, then choose a file to open in Neovim. |
| `<Space>mk` in Neovim | Toggle the browser preview for a Markdown buffer. Use `<Space>mr` to refresh it. |

See the [troubleshooting guide](DOTFILES.md#troubleshooting) for plugin, language
server, and font issues.

## Credits

- [folke](https://github.com/folke/lazy.nvim) for lazy.nvim and Neovim plugins.
- [junegunn](https://github.com/junegunn/fzf-git.sh) for fzf and the bundled `fzf-git.sh` helper.

## License

See [LICENSE](LICENSE) for the GNU General Public License, version 3.
The bundled [`fzf-git.sh`](scripts/scripts/fzf-git.sh) carries its own MIT notice.
