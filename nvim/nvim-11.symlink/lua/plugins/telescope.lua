return {
    {
        'nvim-telescope/telescope.nvim',
        branch = 'master',
        dependencies = {
            'nvim-lua/plenary.nvim',

            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
                config = function()
                    require("telescope").load_extension("fzf")
                end,
            },

            'nvim-telescope/telescope-ui-select.nvim',

            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require('telescope').setup{
                defaults = {
                    layout_strategy = 'flex',
                    layout_config = {
                        flex = {
                            flip_columns = 250
                        }
                    }
                },

                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown()
                    }
                }
            }

            require('telescope').load_extension('fzf')
            require('telescope').load_extension('ui-select')


            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Find string' })
            vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, { desc = 'Find in current buffer' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find NeoVim help' })
            vim.keymap.set('n', '<leader>fm', builtin.man_pages, { desc = 'Find man pages' })
            vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Find previous open files' })

            -- git related mappings
            vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Git status' })
            vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Git branches' })
            vim.keymap.set('n', '<leader>gl', builtin.git_commits, { desc = 'Git log' })
            vim.keymap.set('n', '<leader>gh', builtin.git_bcommits, { desc = 'Git history of current file' })

            -- fuzzy search in current buffer
            vim.keymap.set('n', '<leader>/', function()
                -- You can pass additional configuration to Telescope to change the theme, layout, etc.
                builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = '[/] Fuzzily search in current buffer' })
        end
    },
}
