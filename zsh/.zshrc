# ---------- INIT ----------
# Terminal emulators normally start a non-login shell. Load the user environment
# there too; login shells have already read ~/.zprofile.
if [[ ! -o login && -r "$HOME/.zprofile" ]]; then
    source "$HOME/.zprofile"
fi

# ---------- CONFIGURATION ----------
# Keep Omarchy's shell-scoped environment while using native zsh integrations.
if [[ -r "$OMARCHY_PATH/default/bash/envs" ]]; then
    source "$OMARCHY_PATH/default/bash/envs"
fi

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# ---------- HISTORY ----------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=32768
SAVEHIST=32768
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY

# ---------- COMPLETION ----------
zsh_cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ -d "$zsh_cache_dir" ]] || mkdir -p "$zsh_cache_dir"
autoload -Uz compinit
compinit -d "$zsh_cache_dir/zcompdump-$ZSH_VERSION"
unset zsh_cache_dir
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

if command -v dircolors >/dev/null 2>&1; then
    eval "$(dircolors -b)"
fi

[[ -t 0 ]] && export GPG_TTY="$(tty)"

# ---------- TOOLS INIT ----------
# Tool integrations must be generated for zsh; Omarchy's defaults generate
# Bash code and cannot be sourced here.
if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
    if [[ -t 0 && -t 1 ]]; then
        eval "$(zoxide init zsh)"
    else
        # The POSIX initializer avoids registering ZLE widgets when no terminal
        # is attached while still defining `z` for Omarchy's `zd` helper.
        eval "$(zoxide init posix --hook none)"
    fi
fi

if [[ -t 0 && -t 1 ]] && command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --zsh)"
fi

if command -v try >/dev/null 2>&1; then
    try() {
        unfunction try
        eval "$(SHELL=/usr/bin/zsh command try init "$HOME/Work/tries")"
        try "$@"
    }
fi

# ---------- OMARCHY ----------
# Omarchy's aliases and function modules currently parse in zsh. Load those
# portable pieces directly so the desktop's convenience commands are retained.
if [[ -r "$OMARCHY_PATH/default/bash/aliases" ]]; then
    source "$OMARCHY_PATH/default/bash/aliases"
fi

for omarchy_function_file in "$OMARCHY_PATH"/default/bash/fns/*(N.); do
    source "$omarchy_function_file"
done
unset omarchy_function_file

# Two Omarchy layout helpers use Bash's zero-based array indexing. Run their
# original bodies with ksh-style arrays scoped to the call only.
if (( $+functions[hsl] )); then
    functions[_omarchy_hsl]=$functions[hsl]
    hsl() {
        setopt localoptions ksharrays
        _omarchy_hsl "$@"
    }
fi

if (( $+functions[tsl] )); then
    functions[_omarchy_tsl]=$functions[tsl]
    tsl() {
        setopt localoptions ksharrays
        _omarchy_tsl "$@"
    }
fi

# Bash's `read -p` means "show a prompt" while zsh uses it for a coprocess.
# Keep the Omarchy drive helper's confirmation gate with native zsh syntax.
format-drive() {
    if (( $# != 2 )); then
        echo "Usage: format-drive <device> <name>"
        echo "Example: format-drive /dev/sda 'My Stuff'"
        echo -e "\nAvailable drives:"
        lsblk -d -o NAME -n | awk '{print "/dev/"$1}'
        return
    fi

    echo "WARNING: This will completely erase all data on $1 and label it '$2'."
    local confirm
    read -r "confirm?Are you sure you want to continue? (y/N): "
    if [[ $confirm == [Yy] ]]; then
        sudo wipefs -a "$1"
        sudo dd if=/dev/zero of="$1" bs=1M count=100 status=progress
        sudo parted -s "$1" mklabel gpt
        sudo parted -s "$1" mkpart primary 1MiB 100%
        sudo parted -s "$1" set 1 msftdata on

        local partition="$([[ $1 == *nvme* ]] && echo "${1}p1" || echo "${1}1")"
        sudo partprobe "$1" || true
        sudo udevadm settle || true
        sudo mkfs.exfat -n "$2" "$partition"
        echo "Drive $1 formatted as exFAT and labeled '$2'."
    fi
}

# Lightweight completion for the unified Omarchy command. The command catalog
# is queried at completion time, so new Omarchy subcommands appear after updates.
_omarchy() {
    local prefix="${(j: :)words[1,CURRENT-1]} "
    local -a candidates
    candidates=("${(@f)$(command omarchy commands --json 2>/dev/null |
        jq -r --arg prefix "$prefix" \
            '.commands[].route | select(startswith($prefix)) | ltrimstr($prefix) | split(" ")[0]' |
        sort -u)}")

    if (( ${#candidates} )); then
        compadd -- "${candidates[@]}"
    else
        _files
    fi
}
compdef _omarchy omarchy

# ---------- ALIASES ----------
# Personal aliases intentionally load after Omarchy's aliases. Conflicting old
# shortcuts were renamed in ~/.zaliases so current Omarchy behavior is retained.
[[ -r "$HOME/.zaliases" ]] && source "$HOME/.zaliases"

# ---------- PLUGINS & KEYBINDINGS ----------
# Prompt and line-editor plugins. Syntax highlighting must be sourced last.
if [[ -t 0 && -t 1 && -o zle ]]; then
    bindkey -v
    KEYTIMEOUT=10

    if command -v starship >/dev/null 2>&1 && [[ ${TERM:-} != dumb ]]; then
        eval "$(starship init zsh)"
    fi

    if [[ -r /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#666666'
        ZSH_AUTOSUGGEST_STRATEGY=(history completion)
        ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
        source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
        bindkey -M viins '^E' autosuggest-accept
    fi

    bindkey -M viins '^P' up-line-or-history
    bindkey -M viins '^N' down-line-or-history
    bindkey -r '^G'

    if [[ -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
        ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
        source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    fi
fi

# ---------- LOCAL OVERRIDES ----------
# Machine-specific lines (tool installer hooks, hostnames, secrets) belong in
# ~/.zshrc.local, which is not tracked. Keeping them out of this file stops
# installers from replacing the stow symlink with a regular file.
[[ -r "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
