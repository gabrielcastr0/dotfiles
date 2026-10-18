# ---------- ENVIRONMENT ----------
# User login environment. Omarchy's global /etc/zsh/zprofile already sources
# /etc/profile, so distro and desktop-session variables do not need duplicating.

# ---------- EDITOR ----------
export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-nvim}"
export SUDO_EDITOR="${SUDO_EDITOR:-$EDITOR}"

# ---------- PATHS ----------
typeset -U path PATH
for local_dir in \
    "$HOME/.local/bin" \
    "$HOME/scripts" \
    "$HOME/.local/share/nvim/mason/bin" \
    "$HOME/.console-ninja/.bin" \
    "$HOME/.opencode/bin"; do
    [[ -d "$local_dir" ]] && path=("$local_dir" $path)
done
unset local_dir

if [[ -d "$HOME/.bun/bin" ]]; then
    export BUN_INSTALL="$HOME/.bun"
    path=("$BUN_INSTALL/bin" $path)
fi

if [[ -d "$HOME/.local/share/pnpm" ]]; then
    export PNPM_HOME="$HOME/.local/share/pnpm"
    path=("$PNPM_HOME" $path)
fi

export GOPATH="${GOPATH:-$HOME/go}"
[[ -d "$GOPATH/bin" ]] && path=("$GOPATH/bin" $path)

[[ -r "$HOME/.deno/env" ]] && source "$HOME/.deno/env"
[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# ---------- TOOLS CONFIGURATION ----------
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export TEALDEER_CONFIG_DIR="$HOME/.config/tealdeer/"

# ---------- FZF ----------
export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type=d --hidden --strip-cwd-prefix --exclude .git'
export FZF_DEFAULT_OPTS='--height 50% --layout=default --border --color=hl:#2dd4bf'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"
