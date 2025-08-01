return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
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
        'echasnovski/mini.icons',
        version = '*',
        lazy = true
    },

    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = {}
    },
}
