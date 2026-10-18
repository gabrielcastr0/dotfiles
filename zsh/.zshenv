# ---------- ENVIRONMENT ----------
# Omarchy environment bootstrap is POSIX-compatible and intentionally safe for
# non-interactive shells. This keeps OMARCHY_PATH and user tool shims available
# to SSH commands and other zsh invocations that do not read ~/.zshrc.
if [[ -r /usr/share/omarchy/default/bash/env-bootstrap ]]; then
    source /usr/share/omarchy/default/bash/env-bootstrap
fi

# Machine-specific settings also apply to non-interactive shells.
[[ -r "$HOME/.zshenv.local" ]] && source "$HOME/.zshenv.local"
