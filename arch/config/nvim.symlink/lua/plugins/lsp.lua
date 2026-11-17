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
        'folke/lazydev.nvim',
        ft = 'lua',
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

            -- Quickshell Language Server (binary is named qmlls6 on Arch)
            vim.lsp.config('qmlls', {
                cmd = { 'qmlls6' }
            })

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
                        },
                    })
                end,
                settings = {
                    Lua = {},
                },
            })

            -- gopls attaches to gotmpl by default, but it knows nothing about Hugo and returns
            -- bogus documentHighlight ranges there. Keep it on Go files only.
            -- So we are taking the default file types configured for the server and remove gotmpl
            vim.lsp.config('gopls', {
                filetypes = vim.tbl_filter(function(ft)
                    return ft ~= 'gotmpl'
                end, vim.lsp.config.gopls.filetypes),
            })

            -- Servers are listed by name only; the binary comes from nvim-lspconfig's config.
            -- Overrides (qmlls, lua_ls) must be defined above so the check sees the final cmd.
            -- Arch packages:
            --   pyright                      -> pyright
            --   bashls                       -> bash-language-server
            --   somesass_ls                  -> some-sass-language-server (npm/AUR)
            --   astro                        -> astro-language-server (npm/AUR)
            --   jsonls, html, cssls          -> vscode-langservers-extracted
            --   gopls                        -> gopls
            --   qmlls                        -> qt6-declarative (provides qmlls6)
            --   lua_ls                       -> lua-language-server
            --   yamlls                       -> yaml-language-server
            --   hls                          -> haskell-language-server
            local servers = {
                'pyright', 'bashls', 'somesass_ls', 'astro', 'jsonls', 'gopls',
                'qmlls', 'lua_ls', 'html', 'cssls', 'yamlls',
                -- 'hls',
            }

            local missing = {}
            for _, name in ipairs(servers) do
                local cmd = vim.lsp.config[name].cmd
                -- cmd can be a function (custom launcher); it can't be inspected, so trust it.
                if type(cmd) == 'function' or (type(cmd) == 'table' and vim.fn.executable(cmd[1]) == 1) then
                    vim.lsp.enable(name)
                else
                    table.insert(missing, name .. (type(cmd) == 'table' and (' (' .. cmd[1] .. ')') or ''))
                end
            end

            if #missing > 0 then
                vim.notify('LSP servers not installed, skipped: ' .. table.concat(missing, ', '), vim.log.levels.WARN)
            end
        end
    }
}
