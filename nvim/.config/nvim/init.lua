-- vim ui2
local has_ui2, ui2 = pcall(require, 'vim._core.ui2')
if has_ui2 and type(ui2.enable) == 'function' then
    ui2.enable({
        enable = true,
        msg = {
            target = "cmd", -- options: cmd(classic), msg(similar to noice)
            pager = { height = 1 },
            msg   = { height = 0.5, timeout = 4500 },
            dialog = { height = 0.5 },
            cmd    = { height = 0.5 },
        },
    })
end

local remote_clipboard = "/usr/share/omarchy-nvim/config/lua/config/remote_clipboard.lua"
if vim.fn.filereadable(remote_clipboard) == 1 then
    dofile(remote_clipboard).setup()
end

require("castro.core")
require("castro.lazy")
require("current-theme")
require("castro.terminalpop")
