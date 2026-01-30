return {
    {
        'saghen/blink.cmp',
        -- event = 'VimEnter',
        dependencies = {
            'rafamadriz/friendly-snippets',
            'folke/lazydev.nvim'
        },

        version = '1.*',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = 'enter',

                ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback_to_mappings' },
                ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback_to_mappings' }
            },

            appearance = {
                nerd_font_variant = 'mono'
            },

            completion = {
                menu = {
                    draw = {
                        columns = { {'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'kind' }, { 'source_name' } }
                    }
                }
            },

            sources = {
                default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                }
            },

            fuzzy = { implementation = "lua" },

            signature = { enabled = true }
        }
    }
}
