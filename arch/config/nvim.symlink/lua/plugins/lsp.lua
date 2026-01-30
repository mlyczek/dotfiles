return {
    {
        'j-hui/fidget.nvim',
        opts = {
            notification = {
                window = {
                    avoid = { 'NvimTree' }
                }
            }
        }
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
                    mapkLspKey('<leader>rn', vim.lsp.buf.rename, 'Rename')

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

                    -- The following two autocommands are used to highlight references of the
                    -- word under your cursor when your cursor rests there for a little while.
                    --    See `:help CursorHold` for information about when this is executed
                    --
                    -- When you move your cursor, the highlights will be cleared (the second autocommand).
                    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
                        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
                        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })

                        vim.api.nvim_create_autocmd('LspDetach', {
                            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                            end,
                        })
                    end
                end
            })

            -- vim.lsp.enable('hls')
            vim.lsp.enable('pyright')
            vim.lsp.enable('bashls')
            vim.lsp.enable('somesass_ls')
            vim.lsp.enable('astro')

            -- Special Lua Config, as recommended by neovim help docs
            vim.lsp.config('lua_ls', {
                on_init = function(client)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                        runtime = {
                            version = 'LuaJIT',
                            path = { 'lua/?.lua', 'lua/?/init.lua' },
                        },
                        workspace = {
                            checkThirdParty = false,
                            -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
                            --  See https://github.com/neovim/nvim-lspconfig/issues/3189
                            library = vim.api.nvim_get_runtime_file('', true),
                        },
                    })
                end,
                settings = {
                    Lua = {},
                },
            })
            vim.lsp.enable('lua_ls')
        end
    }
}
