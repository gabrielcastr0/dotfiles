return {
    "azorng/vision.nvim",
    event = "VeryLazy",
    config = function()
        require("vision").setup({})
    end,
}
