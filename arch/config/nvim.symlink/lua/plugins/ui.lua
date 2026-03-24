return {
    {
        "catppuccin/nvim",
        name="cappuccin",
        priority = 1000,
        config = function ()
            require('catppuccin').setup({
                integrations = {
                    fidget = true
                }
            })

            vim.cmd.colorscheme 'catppuccin'
        end
    },


    { "nvim-tree/nvim-web-devicons", lazy = true },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            scope = { enabled = false }
        },
    },

    {
        'echasnovski/mini.pairs',
        version = '*',
        opts = {}
    },

    {
        'echasnovski/mini.surround',
        version = '*',
        opts = {}
    },

    {
        'echasnovski/mini.icons',
        version = '*',
        lazy = true
    },

    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = {}
    },

    {
        'MeanderingProgrammer/render-markdown.nvim',
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    }
}
