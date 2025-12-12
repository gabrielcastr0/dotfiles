# export PATH=$HOME/bin:/usr/local/bin:$PATH
# echo source ~/.bash_profile

# load env vars from .zprofile into the shells
[[ -f ~/.zprofile ]] && source ~/.zprofile

# Linux dircolors
if command -v dircolors &> /dev/null; then
    eval "$(dircolors)"
fi

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

# unbind ctrl g in terminal
bindkey -r "^G"

# Starship 
bindkey -v
if [[ "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select" || \
      "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select-wrapped" ]]; then
    zle -N zle-keymap-select "";
fi
eval "$(starship init zsh)"

# Zoxide
eval "$(zoxide init zsh)"

# FZF
eval "$(fzf --zsh)"

# FZF with Git right in the shell by Junegunn : check out his github below
# Keymaps for this is available at https://github.com/junegunn/fzf-git.sh
source ~/scripts/fzf-git.sh

#User configuration
# export MANPATH="/usr/local/man:$MANPATH"

#----- Vim Editing modes & keymaps ------
# set -o vi  # Commented out - already using bindkey -v above

export EDITOR=nvim
export VISUAL=nvim

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

# -------------------ALIAS----------------------
# These alias need to have the same exact space as written here
# HACK: For Running Go Server using Air
alias air='$(go env GOPATH)/bin/air'

# other Aliases shortcuts
alias c="clear"
alias e="exit"
alias vim="nvim"

# Tmux
# Attach to most recent session or create new one
tmux() {
  if [[ $# -eq 0 ]]; then
    local last_session
    last_session=$(command tmux list-sessions -F '#{session_last_attached} #{session_name}' 2>/dev/null | sort -rn | head -1 | cut -d' ' -f2)
    if [[ -n "$last_session" ]]; then
      command tmux -f "$TMUX_CONF" attach -t "$last_session"
    else
      command tmux -f "$TMUX_CONF" new
    fi
  else
    command tmux -f "$TMUX_CONF" "$@"
  fi
}
alias a="attach"
# calls the tmux new session script
alias tns="~/scripts/tmux-sessionizer"

# fzf 
# called from ~/scripts/
alias nlof="~/scripts/fzf_listoldfiles.sh"
# opens documentation through fzf (eg: git,zsh etc.)
alias fman="compgen -c | fzf | xargs man"

# zoxide (called from ~/scripts/)
alias nzo="~/scripts/zoxide_openfiles_nvim.sh"

# Next level of an ls
# options :  --no-filesize --no-time --no-permissions
alias ls="lsd --long --color=always --icon=always" 

# tree
alias tree="tree -L 3 -a -I '.git' --charset X "
alias dtree="tree -L 3 -a -d -I '.git' --charset X "

# lstr
alias lstr="lstr --icons"

# git aliases
alias gt="git"
alias ga="git add ."
alias gs="git status -s"
alias gc='git commit -m'
alias glog='git log --oneline --graph --all'
alias gh-create='gh repo create --private --source=. --remote=origin && git push -u --all && gh browse'

alias nvim-scratch="NVIM_APPNAME=nvim-scratch nvim"

# lazygit
alias lg="lazygit"

# lazydocker
alias lzd="lazydocker"

# mpd start alias
alias mpds="mpd ~/.config/mpd/mpd.conf"

# obsidian vault path (update this for your system)
# alias castrovault="cd ~/Documents/Obsidian/castroVault/"
# ---------------------------------------

# Zsh plugins - Linux system paths (now handled by Oh My Zsh plugins)
# if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
#     source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# elif [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
#     source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# fi

# Deno environment
if [ -f "$HOME/.deno/env" ]; then
    . "$HOME/.deno/env"
fi

# Rust environment
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

# Manually source zsh plugins (fallback if Oh My Zsh doesn't load them)
if [ -f ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh ]; then
    source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
fi

if [ -f ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh ]; then
    source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
fi

# Set GPG TTY for proper graphical passphrase prompts
export GPG_TTY=$(tty)
