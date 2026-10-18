-- Live markdown + mermaid preview in the browser (served by kitehost.nvim over SSE)
return {
    "selimacerbas/mdkite.nvim",
    dependencies = { "selimacerbas/kitehost.nvim" },
    cmd = "MdKite",
    keys = {
        { "<leader>mk", "<cmd>MdKite toggle<cr>", desc = "Markdown: Toggle browser preview" },
        { "<leader>mr", "<cmd>MdKite refresh<cr>", desc = "Markdown: Refresh browser preview" },
    },
    config = function()
        require("mdkite").setup({
            instance_mode = "takeover",
            default_theme = "dark",
            debounce_ms = 300,
        })
    end,
}
