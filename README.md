# Dotfiles

Personal configuration for my Linux development environment: zsh, Neovim,
Starship, Ghostty and a few scripts. It runs on top of
[Omarchy](https://omarchy.org) (Arch + Hyprland).

## Setup

Everything you need to set up a machine lives in **[`DOTFILES.md`](DOTFILES.md)**:
packages and why each one is there, how to link the configs, post-setup steps,
and the known differences on other distros.

You can follow it by hand, or hand it to an agent:

> Read AGENTS.md and DOTFILES.md, then set up this computer.

The agent rules are in [`AGENTS.md`](AGENTS.md). Either way, the result is
checked by a read-only script:

```bash
dotfiles-doctor   # linked to ~/scripts once the scripts package is stowed
```

## Quick start (Omarchy/Arch)

```bash
git clone git@github.com:gabrielcastr0/dotfiles.git ~/Documents/Projects/dotfiles
cd ~/Documents/Projects/dotfiles
stow -n -v -t ~ nvim zsh starship ghostty scripts
stow -t ~ nvim zsh starship ghostty scripts
```

Follow the [Ghostty entry config and post-setup steps](DOTFILES.md#ghostty-entry-config),
then run `scripts/scripts/dotfiles-doctor`.

## Credits

- [folke](https://github.com/folke): lazy.nvim and Neovim plugins
- [junegunn](https://github.com/junegunn): fzf and fzf-git.sh

## License

MIT
