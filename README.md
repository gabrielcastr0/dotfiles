# Dotfiles

Personal configuration files for my Linux development environment.

## Quick Start

```bash
# 1. Install prerequisites
sudo pacman -S git stow  # Arch
# sudo apt install git stow  # Ubuntu/Debian
# sudo dnf install git stow  # Fedora

# 2. Clone and install
git clone git@github.com:gabrielcastr0/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 3. Install dependencies (see Dependencies section below)

# 4. Stow configurations
stow -t ~ */
```

## What's Included

| Config | Description |
|--------|-------------|
| **Neovim** | Lazy.nvim, LSP, Treesitter, Telescope, nvim-cmp, and more |
| **Tmux** | TPM, Catppuccin theme, session management, vim-tmux navigation |
| **Zsh** | Oh-My-Zsh, Starship prompt, vi mode, shell enhancements |
| **Starship** | Custom prompt configuration |
| **Wezterm** | Terminal emulator config |
| **Zed** | Code editor settings |
| **Scripts** | Custom utilities (fzf-git, tmux-sessionizer, etc.) |

## Dependencies

Install dependencies **before** running stow. Choose your distro below.

### Arch Linux

```bash
# Core tools
sudo pacman -S zsh tmux neovim starship git stow

# Shell enhancements
sudo pacman -S zoxide fzf fd ripgrep bat eza tree lazygit yazi lsd xclip

# Build tools & development
sudo pacman -S base-devel go stylua

# Fonts
sudo pacman -S ttf-jetbrains-mono-nerd

# AUR packages
yay -S atuin wezterm
```

### Fedora

```bash
# Core tools
sudo dnf install zsh tmux neovim git stow

# Starship (not in Fedora repos)
curl -sS https://starship.rs/install.sh | sh

# Shell enhancements
sudo dnf install zoxide fzf fd-find ripgrep bat eza tree lsd xclip golang

# Lazygit
sudo dnf copr enable atim/lazygit -y
sudo dnf install lazygit

# Yazi
sudo dnf copr enable varlad/yazi -y
sudo dnf install yazi

# Atuin
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh

# Build tools
sudo dnf groupinstall "Development Tools"

# Fonts
sudo dnf install jetbrains-mono-fonts-all
# For Nerd Font icons, download from https://www.nerdfonts.com/font-downloads

# Wezterm
curl -LO https://github.com/wez/wezterm/releases/download/latest/wezterm-latest.fedora.rpm
sudo dnf install wezterm-latest.fedora.rpm
```

### Ubuntu/Debian

```bash
# Core tools
sudo apt install zsh tmux neovim git stow

# Starship
curl -sS https://starship.rs/install.sh | sh

# Shell enhancements
sudo apt install fzf fd-find ripgrep bat tree lsd xclip golang

# Zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# Eza
sudo apt install gpg
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update && sudo apt install eza

# Lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit && sudo install lazygit /usr/local/bin && rm lazygit lazygit.tar.gz

# Yazi
cargo install --locked yazi-fm yazi-cli

# Atuin
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh

# Build tools
sudo apt install build-essential

# Fonts
mkdir -p ~/.local/share/fonts && cd ~/.local/share/fonts
curl -fLo "JetBrainsMono Nerd Font.ttf" \
  https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf
fc-cache -fv

# Wezterm
curl -LO https://github.com/wez/wezterm/releases/download/latest/wezterm-latest.Ubuntu22.04.deb
sudo dpkg -i wezterm-latest.Ubuntu22.04.deb
```

> **Note for Ubuntu/Debian:** `fd-find` is installed as `fdfind` and `bat` as `batcat`. Create aliases:
> ```bash
> mkdir -p ~/.local/bin
> ln -s $(which fdfind) ~/.local/bin/fd
> ln -s $(which batcat) ~/.local/bin/bat
> ```

### Oh-My-Zsh + Plugins

```bash
# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install plugins (MUST be cloned to Oh-My-Zsh custom directory)
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

> **Important:** Do NOT install zsh plugins via system package managers. They install to `/usr/share/` which Oh-My-Zsh doesn't check.

### Tmux Plugin Manager

```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/.tmux/plugins/tpm
```

### Development Tools (Optional)

```bash
# Node.js via NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.zshrc && nvm install node

# Deno
curl -fsSL https://deno.land/install.sh | sh

# Bun
curl -fsSL https://bun.sh/install | bash

# Formatters (after Node.js)
npm install -g @biomejs/biome prettier

# Stylua (Lua formatter) - if not installed via pacman
cargo install stylua
```

## Installation

After installing all dependencies:

```bash
cd ~/dotfiles

# Stow all configurations
stow -t ~ */

# Or stow individually
stow -t ~ nvim tmux zsh starship wezterm zed scripts
```

### Post-Stow Setup

1. **Set Zsh as default shell:**
   ```bash
   chsh -s $(which zsh)
   ```

2. **Open Neovim** - Lazy.nvim will auto-install plugins:
   ```bash
   nvim
   ```

3. **Start Tmux and install plugins:**
   ```bash
   tmux
   # Press: Ctrl+b then I (capital i)
   ```

4. **Restart your terminal** to apply all changes.

## Scripts

Custom scripts are symlinked to `~/scripts/`:

| Script | Alias | Description |
|--------|-------|-------------|
| `fzf-git.sh` | `Ctrl+g` | Enhanced git operations with fzf |
| `tmux-sessionizer` | `tns` | Quick tmux session switching |
| `fzf_listoldfiles.sh` | `nlof` | Browse recent Neovim files |
| `zoxide_openfiles_nvim.sh` | `nzo` | Open files from zoxide history |

### Customize tmux-sessionizer paths

Edit `~/scripts/tmux-sessionizer`:
```bash
SEARCH_DIRS=(
    "$HOME/Documents/Projects"
    "$HOME/Desktop"
    "$HOME/dev"
    "$HOME/work"
)
```

## Configuration Locations

After stowing, configs are symlinked to:

| Config | Location |
|--------|----------|
| Neovim | `~/.config/nvim/` |
| Tmux | `~/.config/tmux/` |
| Starship | `~/.config/starship/` |
| Wezterm | `~/.config/wezterm/` |
| Zed | `~/.config/zed/` |
| Zsh | `~/.zshrc`, `~/.zprofile` |
| Scripts | `~/scripts/` |

## Customization

### Themes
- **Neovim:** `<leader>ths` to open theme switcher
- **Tmux:** Edit Catppuccin flavor in `tmux/.config/tmux/tmux.conf`
- **Starship:** Modify palette in `starship/.config/starship/starship.toml`

### Keybindings
- **Neovim:** `nvim/.config/nvim/lua/castro/core/keymaps.lua`
- **Tmux:** `tmux/.config/tmux/tmux.conf`
- **Zsh:** `zsh/.zshrc`

### Adding Neovim Plugins
Add plugin files to `nvim/.config/nvim/lua/castro/plugins/` - Lazy.nvim auto-loads them.

## Troubleshooting

### Zsh: Plugin not found
```
[oh-my-zsh] plugin 'zsh-autosuggestions' not found
```
Plugins must be cloned to `~/.oh-my-zsh/custom/plugins/`. See [Oh-My-Zsh + Plugins](#oh-my-zsh--plugins).

### Zsh: Command not found
Ensure all tools are installed and paths are set. Run `source ~/.zshrc` after changes.

### Neovim: Plugins not loading
```bash
rm ~/.config/nvim/lazy-lock.json
nvim
```

### Neovim: LSP not working
```vim
:Mason      " Check installations
:LspInfo    " Check LSP status
```

### Tmux: Plugins not loading
```bash
rm -rf ~/.config/tmux/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/.tmux/plugins/tpm
# Restart tmux, press Ctrl+b then I
```

### Icons not displaying
Install a Nerd Font and configure your terminal to use it.

## Credits

- [folke](https://github.com/folke) - lazy.nvim and Neovim plugins
- [junegunn](https://github.com/junegunn) - fzf and fzf-git.sh
- [ThePrimeagen](https://github.com/ThePrimeagen) - tmux-sessionizer inspiration

## License

MIT
