#!/usr/bin/env bash
# Zoxide open files in Neovim - use zoxide's directory history to quickly open files

# Query zoxide for directories, sort by frecency (frequency + recency)
selected_dir=$(zoxide query -l | fzf \
    --height 60% \
    --reverse \
    --border \
    --preview 'ls -lah --color=always {} 2>/dev/null | head -50' \
    --preview-window=right:50%:wrap \
    --prompt="Zoxide Directories > " \
    --header="Select a directory to browse files" \
    --bind 'ctrl-/:toggle-preview')

# If no directory selected, exit
if [[ -z "$selected_dir" ]]; then
    exit 0
fi

# Check if directory exists and is accessible
if [[ ! -d "$selected_dir" ]]; then
    echo "Error: Directory does not exist or is not accessible"
    exit 1
fi

# Use fd to list files in the selected directory and fzf to select a file
selected_file=$(fd . "$selected_dir" \
    --type f \
    --hidden \
    --exclude .git \
    --exclude node_modules \
    --exclude .venv \
    --exclude venv \
    --exclude __pycache__ \
    --max-depth 5 \
    2>/dev/null | fzf \
    --height 60% \
    --reverse \
    --border \
    --preview 'bat --style=numbers --color=always --line-range :500 {}' \
    --preview-window=right:60%:wrap \
    --prompt="Files > " \
    --header="Select a file to open in Neovim (or ESC to open directory)" \
    --bind 'ctrl-/:toggle-preview')

# If a file was selected, open it in Neovim
if [[ -n "$selected_file" ]]; then
    nvim "$selected_file"
else
    # If no file selected but directory was chosen, open directory in Neovim
    nvim "$selected_dir"
fi
