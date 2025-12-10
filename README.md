# Dotfiles

Personal configuration files for my Linux development environment.

## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [What's Included](#whats-included)
- [Manual Dependencies](#manual-dependencies)
- [Post-Installation Setup](#post-installation-setup)
- [Scripts](#scripts)
- [Troubleshooting](#troubleshooting)

## Overview

This repository contains my dotfiles managed with GNU Stow, including configurations for:
- Neovim (with extensive plugin setup)
- Tmux (with TPM and various plugins)
- Zsh (with Oh-My-Zsh)
- Starship (shell prompt)
- Wezterm (terminal emulator)
- Zed (code editor)

## Prerequisites

### System Requirements
- Linux (Arch, Ubuntu, Debian, Fedora, etc.)
- Git
- GNU Stow (for managing symlinks)

### Install GNU Stow

```bash
# Arch Linux
sudo pacman -S stow

# Ubuntu/Debian
sudo apt install stow

# Fedora
sudo dnf install stow

# openSUSE
sudo zypper install stow
```

## Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

2. Use GNU Stow to create symlinks:
```bash
# Install all configurations
stow -t ~ */

# Or install specific configurations
stow -t ~ nvim
stow -t ~ tmux
stow -t ~ zsh
stow -t ~ starship
stow -t ~ wezterm
stow -t ~ zed
stow -t ~ scripts
```

## What's Included

### Neovim Configuration
- Plugin manager: [lazy.nvim](https://github.com/folke/lazy.nvim) (auto-installs on first launch)
- LSP support with Mason
- Autocompletion with nvim-cmp
- File explorer with nvim-tree and oil.nvim
- Fuzzy finder with Telescope
- Git integration (Gitsigns, Fugitive, Git Worktree)
- Debugging support (nvim-dap)
- Formatting and linting
- Treesitter for syntax highlighting
- And many more plugins...

### Tmux Configuration
- Plugin manager: TPM
- Catppuccin theme
- Session management with tmux-sessionx
- Vim-tmux navigation integration
- Session persistence (resurrect/continuum)

### Zsh Configuration
- Oh-My-Zsh framework
- Starship prompt
- Vi mode keybindings
- Multiple shell enhancements (zoxide, fzf, atuin)

### Custom Scripts
All scripts are included in the `scripts/` directory and will be symlinked to `~/scripts/`:
- `fzf-git.sh` - Enhanced git operations with fzf
- `tmux-sessionizer` - Quick tmux session switching based on project directories
- `fzf_listoldfiles.sh` - Browse and open recent Neovim files
- `zoxide_openfiles_nvim.sh` - Open files from zoxide directory history

## Manual Dependencies

The following tools need to be installed manually before the configurations will work properly:

### Core Tools

#### Shell & Terminal

**Arch Linux:**
```bash
sudo pacman -S zsh tmux neovim starship
```

**Ubuntu/Debian:**
```bash
sudo apt install zsh tmux neovim
# Starship (from official installer)
curl -sS https://starship.rs/install.sh | sh
```

**Fedora:**
```bash
sudo dnf install zsh tmux neovim
# Starship (not in Fedora repos - use official installer)
curl -sS https://starship.rs/install.sh | sh
```

#### Oh-My-Zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

#### Wezterm
Visit [Wezterm Downloads](https://wezfurlong.org/wezterm/installation.html) for installation instructions specific to your distro.

```bash
# Arch Linux
yay -S wezterm

# Ubuntu/Debian (from releases)
curl -LO https://github.com/wez/wezterm/releases/download/latest/wezterm-latest.Ubuntu22.04.deb
sudo dpkg -i wezterm-latest.Ubuntu22.04.deb

# Fedora (from releases)
curl -LO https://github.com/wez/wezterm/releases/download/latest/wezterm-latest.fedora.rpm
sudo dnf install wezterm-latest.fedora.rpm
```

### Shell Enhancement Tools

**Arch Linux:**
```bash
sudo pacman -S zoxide fzf fd ripgrep bat eza tree lazygit yazi lsd
yay -S atuin  # or use official installer
```

**Ubuntu/Debian:**
```bash
# Core tools
sudo apt install fzf fd-find ripgrep bat tree lsd

# Modern alternatives (may need to install from releases)
# zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# eza (ls replacement)
sudo apt install gpg
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install eza

# lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# yazi
cargo install --locked yazi-fm yazi-cli
# or download from releases

# atuin
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
```

**Fedora:**
```bash
sudo dnf install zoxide fzf fd-find ripgrep bat eza tree lsd
sudo dnf copr enable atim/lazygit -y
sudo dnf install lazygit
# Install atuin from official installer
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
# Install yazi (from copr or cargo)
sudo dnf copr enable varlad/yazi -y
sudo dnf install yazi
# Or via cargo: cargo install --locked yazi-fm yazi-cli
```

**Note for Ubuntu/Debian users:**
- `fd-find` is installed as `fdfind`, you may want to create an alias: `ln -s $(which fdfind) ~/.local/bin/fd`
- `bat` might be installed as `batcat`, create an alias: `ln -s $(which batcat) ~/.local/bin/bat`

### Development Tools

**Node.js (via NVM - recommended):**
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.zshrc
nvm install node
```

**Go:**
```bash
# Arch Linux
sudo pacman -S go

# Ubuntu/Debian
sudo apt install golang-go

# Fedora
sudo dnf install golang
```

**Deno:**
```bash
curl -fsSL https://deno.land/install.sh | sh
```

**Bun:**
```bash
curl -fsSL https://bun.sh/install | bash
```

**Build Tools (required for some Neovim plugins):**
```bash
# Arch Linux
sudo pacman -S base-devel

# Ubuntu/Debian
sudo apt install build-essential

# Fedora
sudo dnf groupinstall "Development Tools"
```

### Neovim-Specific Dependencies

**Formatters and Linters:**
```bash
# Install via npm (after Node.js is installed)
npm install -g @biomejs/biome prettier

# Stylua (Lua formatter)
# Arch
sudo pacman -S stylua

# Others - install from releases or cargo
cargo install stylua
```

**Image Clipboard Support:**
```bash
# Install xclip for clipboard support
# Arch
sudo pacman -S xclip

# Ubuntu/Debian
sudo apt install xclip

# Fedora
sudo dnf install xclip
```

### Zsh Plugins (for Oh-My-Zsh)

These plugins must be installed to the Oh-My-Zsh custom plugins directory:

```bash
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

> **Note:** Do NOT use system package managers (`pacman`, `apt`, `dnf`) for these plugins. System packages install to `/usr/share/` which Oh-My-Zsh doesn't check. The plugins must be cloned directly into `~/.oh-my-zsh/custom/plugins/`.

### Tmux Plugin Manager (TPM)

```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/.tmux/plugins/tpm
```

After installing TPM, launch tmux and press `Ctrl+b` then `I` (capital i) to install plugins.

### Fonts

Install a Nerd Font for proper icon support:

**Arch Linux:**
```bash
sudo pacman -S ttf-jetbrains-mono-nerd
```

**Ubuntu/Debian:**
```bash
# Download from Nerd Fonts releases
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLo "JetBrains Mono Nerd Font Complete.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf
fc-cache -fv
```

**Fedora:**
```bash
sudo dnf install jetbrains-mono-fonts-all
# Then install Nerd Font version manually or from copr
```

Then configure your terminal to use the font.

## Post-Installation Setup

### 1. Stow Scripts Directory

The scripts are included in this repository. Stow them to make them available system-wide:

```bash
cd ~/dotfiles
stow -t ~ scripts
```

This will create symlinks in `~/scripts/` for all custom scripts.

### 2. Initialize Neovim

Launch Neovim for the first time:
```bash
nvim
```

Lazy.nvim will automatically install all plugins. Mason will prompt you to install LSP servers and formatters. You can also run:
```
:Mason
```
to manually install language servers and tools.

### 3. Initialize Tmux Plugins

Start tmux and install plugins:
```bash
tmux
# Press: Ctrl+b then I (capital i)
```

### 4. Configure FZF

FZF should work out of the box after installation. To enable additional shell integrations:

```bash
# The keybindings are already configured in .zshrc
# Just ensure fzf is in your PATH
```

### 5. Shell Configuration

Update your shell to zsh if not already:
```bash
chsh -s $(which zsh)
```

Then restart your terminal or source the configuration:
```bash
source ~/.zshrc
```

### 6. Update .zshrc for Your System

Edit `~/.zshrc` and update the following if needed:
- Remove or comment out line 7 if you don't use Homebrew: `eval "$(brew shellenv)"`
- Remove or comment out line 11 if you don't have GNU dircolors: `eval "$(gdircolors)"`
- Line 148 references Deno path - update for your system

## Scripts

The following custom scripts are included and will be available after stowing:

### Scripts Overview

1. **fzf-git.sh** (from junegunn)
   - Enhanced git operations with fzf
   - Provides fuzzy finding for branches, commits, files, etc.
   - Keybindings: `Ctrl+g` followed by various keys

2. **tmux-sessionizer**
   - Quickly create or switch tmux sessions from project directories
   - Searches predefined directories for projects
   - Usage: `tns` (alias) or `tmux-sessionizer [path]`
   - Tmux keybinding: `Ctrl+b` then `f`

3. **fzf_listoldfiles.sh**
   - Browse and open recently used files from Neovim history
   - Uses bat for file preview
   - Usage: `nlof` (alias)

4. **zoxide_openfiles_nvim.sh**
   - Open files from directories in your zoxide history
   - Two-step selection: directory, then file
   - Usage: `nzo` (alias)

### Customizing Script Search Paths

Edit `scripts/tmux-sessionizer` to customize which directories are searched:

```bash
SEARCH_DIRS=(
    "$HOME/Documents/Projects"
    "$HOME/Desktop"
    "$HOME/dev"
    "$HOME/work"
)
```

## Troubleshooting

### Neovim Issues

**Plugins not loading:**
```bash
# Remove lazy-lock and reinstall
rm ~/.config/nvim/lazy-lock.json
nvim
```

**LSP not working:**
```bash
# Check Mason installations
:Mason
# Check LSP status
:LspInfo
```

**Treesitter errors:**
```bash
# Update parsers
:TSUpdate
```

**Image clipboard not working:**
Make sure `xclip` is installed and working:
```bash
xclip -version
```

### Tmux Issues

**Plugins not loading:**
```bash
# Reinstall TPM
rm -rf ~/.config/tmux/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/.tmux/plugins/tpm
# Restart tmux and press Ctrl+b then I
```

**Colors not working:**
Ensure your terminal supports true color and has `TERM` set correctly. The tmux config sets:
```bash
set -g default-terminal "tmux-256color"
set -ag terminal-overrides ",xterm-256color:RGB"
```

### Zsh Issues

**Command not found:**
- Ensure all tools are installed (check each section above)
- Check that paths are correctly set in `.zprofile`
- Source your configuration: `source ~/.zshrc`

**Oh-My-Zsh not loading:**
- Verify Oh-My-Zsh installation: `ls ~/.oh-my-zsh`
- Reinstall if necessary

**Brew-related errors:**
The .zshrc includes `eval "$(brew shellenv)"` which is macOS-specific. Comment this out:
```bash
# Line 7 in .zshrc
# eval "$(brew shellenv)"
```

**dircolors error:**
If you don't have GNU coreutils installed, comment out line 11:
```bash
# eval "$(gdircolors)"
```

### Font Issues

**Icons not displaying:**
- Install a Nerd Font (see Fonts section)
- Configure your terminal to use the Nerd Font
- Restart your terminal
- Test in terminal: `echo "\uf41e"` should show a folder icon

### Script Issues

**Scripts not found:**
Ensure scripts are stowed and executable:
```bash
cd ~/dotfiles
stow -t ~ scripts
ls -la ~/scripts/  # Verify symlinks exist
chmod +x ~/scripts/*  # Ensure they're executable
```

**fd/bat command not found:**
On Ubuntu/Debian, these may be named differently:
```bash
ln -s $(which fdfind) ~/.local/bin/fd
ln -s $(which batcat) ~/.local/bin/bat
```

## Configuration Locations

After running stow, configurations will be symlinked to:
- Neovim: `~/.config/nvim/`
- Tmux: `~/.config/tmux/`
- Starship: `~/.config/starship/`
- Wezterm: `~/.config/wezterm/`
- Zed: `~/.config/zed/`
- Zsh: `~/.zshrc` and `~/.zprofile`
- Scripts: `~/scripts/`

## Customization

### Changing Themes
- **Neovim:** Use `<leader>ths` to open the theme switcher (Telescope themes)
- **Tmux:** Edit the Catppuccin flavor in `tmux/.config/tmux/tmux.conf` (line 77)
- **Starship:** Modify palette in `starship/.config/starship/starship.toml` (line 20)

### Adding New Neovim Plugins
Add new plugin files in `nvim/.config/nvim/lua/castro/plugins/`
Lazy.nvim will automatically load them on next Neovim start.

### Modifying Keybindings
- **Neovim:** Edit `nvim/.config/nvim/lua/castro/core/keymaps.lua`
- **Tmux:** Edit `tmux/.config/tmux/tmux.conf`
- **Zsh:** Edit `zsh/.zshrc`

### Updating Scripts
All scripts are in the `scripts/` directory. After editing, the changes will be immediately available since stow creates symlinks.

## License

MIT License - feel free to use and modify as needed.

## Credits

This configuration is inspired by various dotfiles in the community. Special thanks to:
- [folke](https://github.com/folke) - for lazy.nvim and many Neovim plugins
- [junegunn](https://github.com/junegunn) - for fzf and fzf-git.sh
- [ThePrimeagen](https://github.com/ThePrimeagen) - for tmux-sessionizer inspiration
- The Neovim, Tmux, and Zsh communities
