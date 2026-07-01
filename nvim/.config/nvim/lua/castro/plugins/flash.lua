return {
    -- Jump anywhere on screen with a 2-char label.
    -- NOTE: your `s` key is taken by mini.surround (sa/ds/sr...), so flash's
    -- jump is mapped to <leader>j instead of the default `s`.
    -- Flash also transparently SUPERCHARGES f/t/F/T and / search with labels,
    -- which needs no keymap and is where most of the daily speed-up comes from.
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            modes = {
                -- enhance f/t/F/T: after `f{char}`, press the label to jump to
                -- any other match of that char on the line/screen, `;`/`,` repeat.
                char = { enabled = true },
                -- label the matches while typing a `/` or `?` search.
                search = { enabled = true },
            },
        },
        keys = {
            { "<leader>j", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash jump" },
            { "<leader>J", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter select" },
            { "r",         mode = "o",               function() require("flash").remote() end,     desc = "Remote Flash" },
            { "R",         mode = { "o", "x" },       function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        },
    },
}
