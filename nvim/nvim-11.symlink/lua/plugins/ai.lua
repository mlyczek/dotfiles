return {
    {
        'github/copilot.vim',
        init = function ()
            vim.g.copilot_enabled = false
        end
    },

    {
        "olimorris/codecompanion.nvim",
        opts = {},
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "github/copilot.vim"
        },
    },
}
