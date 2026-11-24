#!/usr/bin/env bash
# FZF list old files - browse and open recently used files in Neovim

# Get Neovim's oldfiles list and open selected file
# This requires nvim to be installed

# Get the list of old files from Neovim's shada/viminfo
# Use nvim --headless to query old files
oldfiles=$(nvim --headless -u NONE -c 'lua for _, file in ipairs(vim.v.oldfiles) do if vim.fn.filereadable(file) == 1 then io.stdout:write(file, "\n") end end' -c 'set shada=' -c 'quit' 2>/dev/null)

# If no old files found, exit
if [[ -z "$oldfiles" ]]; then
    echo "No recent files found"
    exit 1
fi

# Use fzf to select a file with preview
selected=$(echo "$oldfiles" | fzf \
    --height 60% \
    --reverse \
    --border \
    --preview 'bat --style=numbers --color=always --line-range :500 {}' \
    --preview-window=right:60%:wrap \
    --prompt="Recent Files > " \
    --header="Select a file to open in Neovim" \
    --bind 'ctrl-/:toggle-preview')

# If a file was selected, open it in Neovim
if [[ -n "$selected" ]]; then
    nvim "$selected"
fi
