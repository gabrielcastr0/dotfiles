# ---------- INIT ----------
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# echo source ~/.bash_profile

# load env vars from .zprofile into the shells
[[ -f ~/.zprofile ]] && source ~/.zprofile

# ---------- CONFIGURATION ----------
# Linux dircolors
if command -v dircolors &> /dev/null; then
    eval "$(dircolors)"
fi

# Set GPG TTY for proper graphical passphrase prompts
export GPG_TTY=$(tty)

export SUDO_EDITOR="$(command -v nvim)"

#User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# ---------- PLUGINS ----------
# zsh plugins (must be defined BEFORE sourcing oh-my-zsh)
plugins=(
    git
    web-search
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Plugin Configuration
# zsh-autosuggestions configuration
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# zsh-syntax-highlighting configuration
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

source $ZSH/oh-my-zsh.sh

# Zsh plugins - Linux system paths (now handled by Oh My Zsh plugins)
# if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
#     source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# elif [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
#     source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# fi

# Manually source zsh plugins (fallback if Oh My Zsh doesn't load them)
if [ -f ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh ]; then
    source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
fi

if [ -f ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh ]; then
    source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
fi

# ---------- KEYBINDINGS ----------
# unbind ctrl g in terminal
bindkey -r "^G"

# Starship 
bindkey -v
if [[ "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select" || \
      "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select-wrapped" ]]; then
    zle -N zle-keymap-select "";
fi

#----- Vim Editing modes & keymaps ------
# set -o vi  # Commented out - already using bindkey -v above

# Fix special characters in Vi insert mode
bindkey -M viins '~' self-insert
bindkey -M viins '`' self-insert
bindkey -M viins '@' self-insert
bindkey -M viins '#' self-insert
bindkey -M viins '$' self-insert
bindkey -M viins '%' self-insert
bindkey -M viins '^' self-insert
bindkey -M viins '&' self-insert
bindkey -M viins '*' self-insert
bindkey -M viins '(' self-insert
bindkey -M viins ')' self-insert
bindkey -M viins '[' self-insert
bindkey -M viins ']' self-insert
bindkey -M viins '{' self-insert
bindkey -M viins '}' self-insert
bindkey -M viins '\' self-insert
bindkey -M viins '|' self-insert
bindkey -M viins '<' self-insert
bindkey -M viins '>' self-insert

bindkey -M viins '^E' autosuggest-accept
bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^N' down-line-or-history
#----------------------------------------

# ---------- TOOLS INIT ----------
# Starship
eval "$(starship init zsh)"

# Zoxide
eval "$(zoxide init zsh)"

# FZF
fzf_zsh_integration=$(fzf --zsh 2>/dev/null)
if [ $? -eq 0 ]; then
    eval "$fzf_zsh_integration"
else
    [ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
    [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
fi

# FZF with Git right in the shell by Junegunn : check out his github below
# Keymaps for this is available at https://github.com/junegunn/fzf-git.sh
source ~/scripts/fzf-git.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# bun completions
[ -s "/home/gc4str0/.bun/_bun" ] && source "/home/gc4str0/.bun/_bun"

# ---------- ALIASES ----------
# load aliases (after oh-my-zsh to prevent overrides)
[[ -f ~/.zaliases ]] && source ~/.zaliases

alias claude-mem='bun "/home/gc4str0/.claude/plugins/cache/thedotmack/claude-mem/12.1.0/scripts/worker-service.cjs"'

# ---------- PATHS ----------
# pnpm
export PNPM_HOME="/home/gc4str0/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end

# Added by Antigravity CLI installer
export PATH="/home/gc4str0/.local/bin:$PATH"

