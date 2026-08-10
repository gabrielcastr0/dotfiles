# ---------- ENVIRONMENT ----------
export LANG=en_US.UTF-8

# GTK4 GSK rendering backend
export GSK_RENDERER=vulkan

# Qt widget style (Kvantum)
export QT_STYLE_OVERRIDE=kvantum

# ---------- EDITOR ----------
# Default editors
export EDITOR=nvim
export VISUAL=nvim

# ---------- PATHS ----------
# Add local bin directories to PATH
export PATH="$HOME/.local/bin:$PATH"

# Add local ~/scripts to the PATH
export PATH="$HOME/scripts:$PATH"

# Mason
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

# Console Ninja
export PATH=~/.console-ninja/.bin:$PATH

# opencode
export PATH=/home/gc4str0/.opencode/bin:$PATH

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac

# Golang
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
export PATH=$PATH:$(go env GOPATH)/bin

# Deno environment
if [ -f "$HOME/.deno/env" ]; then
    . "$HOME/.deno/env"
fi

# Rust environment
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi
case ":$PATH:" in
    *":$HOME/.cargo/bin:"*) ;;
    *) export PATH="$HOME/.cargo/bin:$PATH" ;;
esac

# Added by Antigravity CLI installer
export PATH="/home/gc4str0/.local/bin:$PATH"

# ---------- TOOLS CONFIGURATION ----------
# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"


# Starship PATH
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# Tealdeer
export TEALDEER_CONFIG_DIR="$HOME/.config/tealdeer/"

# Oh-my-zsh
# NOTE : Disabled Shell Prompt: Currently using Starship
# NOTE: using oh-my-zsh only for zsh plugins management
export ZSH="$HOME/.oh-my-zsh"

# Using Starship instead of p10k
# export ZSH_THEME="powerlevel10k/powerlevel10k"

# FZF
# Set up fzf key bindings and fuzzy completion
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"

# Setup fzf previews
export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"


# ---------- ENVMAN ----------
# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
