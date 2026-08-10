return {
	"nvim-lua/plenary.nvim", --lua functions that many plugins use

    -- fixes the well know nvim bug
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                {
                    path = "${3rd}/plenary.nvim/lua",
                    words = { "plenary" }
                },
            },
        },
    }

}
