export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export LANG=en_US.UTF-8

#------------All PATHS------------

# Add local bin directories to PATH
export PATH="$HOME/.local/bin:$PATH"

# Add local ~/scripts to the PATH
export PATH="$HOME/scripts:$PATH"

# Mason
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

# Tmux
export TMUX_CONF="$HOME/.config/tmux/tmux.conf"

# Starship PATH
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# Tealdeer
export TEALDEER_CONFIG_DIR="$HOME/.config/tealdeer/"

# Path to your oh-my-zsh installation.
# NOTE : Disabled Shell Prompt: Currently using Starship
# NOTE: using oh-my-zsh only for zsh plugins management
export ZSH="$HOME/.oh-my-zsh"

# Using Starship instead of p10k
# export ZSH_THEME="powerlevel10k/powerlevel10k"

# ------------FZF--------------
# Set up fzf key bindings and fuzzy completion
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"

# Setup fzf previews
export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'lsd --icon=always --tree --color=always {} | head -200'"

# fzf preview for tmux
export FZF_TMUX_OPTS=" -p90%,70% "
# -----------------------------

# Console Ninja
export PATH=~/.console-ninja/.bin:$PATH

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

#------------Langs------------

# Golang
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
export PATH=$PATH:$(go env GOPATH)/bin






# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"


