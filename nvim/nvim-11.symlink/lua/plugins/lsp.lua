return {
    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
    },

    {
        'j-hui/fidget.nvim',
        tag = 'v1.6.1',
        opts = {}
    },

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'j-hui/fidget.nvim',

        },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
                callback = function(event)
                    local mapkLspKey = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end

                    mapkLspKey('<M-CR>', vim.lsp.buf.code_action, 'Apply code action')
                    mapkLspKey('<leader>fw', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Find workspace symbols')
                    mapkLspKey('<leader>fd', require('telescope.builtin').lsp_document_symbols, 'Find document symbols')
                    mapkLspKey('<leader>fr', require('telescope.builtin').lsp_references, 'Find references')
                    mapkLspKey('<leader>rn', vim.lsp.buf.rename, 'Rename')
                    mapkLspKey('<leader>gd', require('telescope.builtin').lsp_definitions, 'Go to definition')
                    mapkLspKey('<leader>gi', require('telescope.builtin').lsp_implementations, 'Go to implementations')

                    local client = vim.lsp.get_client_by_id(event.data.client_id)

                    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                        vim.lsp.inlay_hint.enable(true, { bufnr = event.buf})
                    end

                    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
                        mapkLspKey('<leader>fo', vim.lsp.buf.format, 'Format code', 'n')
                    end

                    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_rangeFormatting) then
                        mapkLspKey('<leader>fo', vim.lsp.buf.format, 'Format range of code', 'v')
                    end
                end
            })

            vim.lsp.enable('hls')
            vim.lsp.enable('pyright')
            vim.lsp.enable('bashls')
            vim.lsp.enable('somesass_ls')
            vim.lsp.enable('astro')
            vim.lsp.enable('lua_ls')
        end
    }
}
