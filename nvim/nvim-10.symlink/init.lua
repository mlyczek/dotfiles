-- Clipboard settings, always use clipboard for all delete, yank, change, put
-- operation, see https://goo.gl/YAHBbJ
vim.opt.clipboard:append { 'unnamedplus' }

-- show line number and relative line number
vim.opt.number = true
vim.opt.relativenumber = true

-- disable swapfiles
vim.opt.swapfile = false
-- Persistent undo even after you close a file and re-open it
vim.opt.undofile = false

-- better splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- TODO consider adding mappings for splits here

-- General tab settings
vim.opt.tabstop = 4      -- number of visual spaces per TAB
vim.opt.softtabstop = 4  -- number of spaces in tab when editing
vim.opt.shiftwidth = 4   -- number of spaces to use for autoindent
vim.opt.expandtab = true -- expand tab to spaces so that tabs are spaces

-- show current line where the cursor is
vim.opt.cursorline = true

-- Ignore case in general, but become case-sensitive when uppercase is present
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.encoding = 'utf8'

-- Character to show before the lines that have been soft-wrapped
vim.opt.showbreak = '↪'

-- Minimum lines to keep above and below cursor when scrolling
vim.opt.scrolloff = 3

-- Do not show mode on command line since vim-airline can show it
-- vim.opt.showmode = false

-- show some special characters
vim.opt.list = true
vim.opt.listchars:append { tab = ">-", eol = '¶', trail = '·', nbsp = '+'}

-- Ask for confirmation when handling unsaved or read-only files
vim.opt.confirm = true

-- Do not use visual and errorbells
vim.opt.visualbell = true
vim.opt.errorbells = false

vim.opt.spelllang = 'en'

-- Align indent to next multiple value of shiftwidth. For its meaning,
-- see http://tinyurl.com/y5n87a6m
vim.opt.shiftround = true

-- Do not add two space after a period when joining lines or formatting texts, see https://tinyurl.com/y3yy9kov
vim.opt.joinspaces = false

-- required for colorscheme
vim.opt.termguicolors = true
vim.opt.background = dark

-- disable unused Neovim providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.diagnostic.config {
    virtual_text = false -- disable diagnostics being shown as virtual text
}

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local term_settings = augroup('term_settings', { clear = true })
-- Do not use number and relative number for terminal inside nvim
autocmd('TermOpen', {
    group = term_settings,
    pattern = '*',
    command = 'setlocal norelativenumber nonumber'
})
-- Go to insert mode by default to start typing command
autocmd('TermOpen', {
    group = term_settings,
    pattern = '*',
    command = 'startinsert'
})

local accurate_syn_highlight = augroup('accurate_syn_highlight', { clear = true })
-- More accurate syntax highlighting? (see `:h syn-sync`)
autocmd('BufEnter', {
    group = accurate_syn_highlight,
    pattern = '*',
    command = ':syntax sync fromstart'
})

-- Filetype indentation
local file_type_indentation = augroup('file_type_indentation', { clear = true })
autocmd('Filetype', {
    group = file_type_indentation,
    pattern = { 'ruby', 'eruby' },
    command = 'setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab'
})
autocmd('Filetype', {
    group = file_type_indentation,
    pattern = { 'css' ,'scss', 'sass', 'less' },
    command = 'setlocal iskeyword+=-'
})

local spell_check = augroup('spell_check', { clear = true })
autocmd('Filetype', {
    group = spell_check,
    pattern = 'gitcommit',
    command = 'setlocal spell'
})

local keymap = vim.keymap.set

keymap('n', '<Leader><space>', ':noh<cr>')
keymap('n', '<Leader>s', ':%s/<<C-r><C-w>>/')

-- close all
keymap('n', '<Leader>q', ':qa<cr>', { desc = 'Close all' })

-- better split navigation
keymap('n', '<C-J>', '<C-w><C-J>')
keymap('n', '<C-K>', '<C-w><C-K>')
keymap('n', '<C-L>', '<C-w><C-L>')
keymap('n', '<C-H>', '<C-w><C-H>')

-- Split resizing
keymap('n', '<M-,>', '<C-W>5<')
keymap('n', '<M-.>', '<C-W>5>')
keymap('n', '<M-->', '<C-W>5-')
keymap('n', '<M-=>', '<C-W>5+')

-- disable arrow keys completely in insert mode
keymap('i', '<up>', '<nop>')
keymap('i', '<down>', '<nop>')
keymap('i', '<left>', '<nop>')
keymap('i', '<right>', '<nop>')

-- terminal
keymap('t', '<Esc><Esc>', '<C-\\><C-n>')
keymap('t', '<C-h>', '<C-\\><C-N><C-w>h')
keymap('t', '<C-j>', '<C-\\><C-N><C-w>j')
keymap('t', '<C-k>', '<C-\\><C-N><C-w>k')
keymap('t', '<C-l>', '<C-\\><C-N><C-w>l')


-- Plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "catppuccin"
        end
    },
    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false, -- make sure we load this during startup if it is your main colorscheme
    --     priority = 1000, -- make sure to load this before all the other start plugins
    --     config = function()
    --         -- load the colorscheme here
    --         vim.cmd([[colorscheme tokyonight]])
    --     end,
    -- },

    { "nvim-tree/nvim-web-devicons", lazy = true },

    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("nvim-tree").setup {
                view = {
                    width = 40
                },
                renderer = {
                    group_empty = true,
                    highlight_opened_files = "icon"
                },
                actions = {
                    open_file = {
                        quit_on_open = true
                    }
                }
            }

            keymap("n", "<F5>", ":NvimTreeToggle<cr>", {silent = true, noremap = true})
            keymap("n", "<leader><F5>", ":NvimTreeFindFile<cr>", {silent = true, noremap = true})
        end,
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require('lualine').setup()
        end
    },

    'neovimhaskell/haskell-vim',

    'joshdick/onedark.vim',

    'tpope/vim-fugitive',

    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "bash", "css", "dockerfile",
                    "git_config", "git_rebase", "gitcommit", "haskell", "java", "javascript", "json", "python",
                    "scala", "sql", "tmux", "typescript", "yaml", "terraform", "hcl", "clojure", "astro", "html"
                },

                highlight = { enable = true }
            }
        end
    },

    'nvim-lua/plenary.nvim',

    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup{
                defaults = {
                    layout_strategy = 'flex',
                    layout_config = {
                        flex = {
                            flip_columns = 250
                        }
                    }
                }
            }

            local builtin = require('telescope.builtin')
            keymap('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
            keymap('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
            keymap('n', '<leader>fg', builtin.live_grep, { desc = 'Find string' })
            keymap('n', '<leader>fc', builtin.current_buffer_fuzzy_find, { desc = 'Find in current buffer' })
            keymap('n', '<leader>fh', builtin.help_tags, { desc = 'Find NeoVim help' })
            keymap('n', '<leader>fm', builtin.man_pages, { desc = 'Find man pages' })
            keymap('n', '<leader>fo', builtin.oldfiles, { desc = 'Find previous open files' })

            -- git related mappings
            keymap('n', '<leader>gs', builtin.git_status, { desc = 'Git status' })
            keymap('n', '<leader>gb', builtin.git_branches, { desc = 'Git branches' })
            keymap('n', '<leader>gl', builtin.git_commits, { desc = 'Git log' })
            keymap('n', '<leader>gh', builtin.git_bcommits, { desc = 'Git history of current file' })
        end
    },

    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },


    {
        'echasnovski/mini.pairs',
        version = '*',
        config = function()
            require('mini.pairs').setup()
        end
    },

    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },

    -- ******************* LSP ************************

    {
        'j-hui/fidget.nvim',
        tag = 'v1.4.5',
        opts = {}
    },

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp'
        },
        config = function()
            -- get default capabilities from cmp-nvim-lsp so that LSP can take advantage of them
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local lspconfig = require('lspconfig')

            -- Add cmp_nvim_lsp capabilities settings to lspconfig
            -- This should be executed before you configure any language server
            local lspconfig_defaults = lspconfig.util.default_config
            lspconfig_defaults.capabilities = vim.tbl_deep_extend('force', lspconfig_defaults.capabilities, capabilities)

            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local client = vim.lsp.get_client_by_id(event.data.client_id)

                    local mapkLspKey = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc})
                    end

                    mapkLspKey('<M-CR>', vim.lsp.buf.code_action, 'Apply code action')
                    mapkLspKey('<leader>fs', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Find workspace symbols')
                    mapkLspKey('<leader>fr', require('telescope.builtin').lsp_references, 'Find references')
                    mapkLspKey('<leader>rn', vim.lsp.buf.rename, 'Rename')
                    mapkLspKey('<leader>gd', require('telescope.builtin').lsp_definitions, 'Go to definition')

                    if client.supports_method('textDocument/inlayHint') then
                        vim.lsp.inlay_hint.enable(true, { bufnr = event.buf})
                    end

                    if client.supports_method('textDocument/formatting') then
                        mapkLspKey('<leader>fo', vim.lsp.buf.format, 'Format code', 'n')
                    end

                    if client.supports_method('textDocument/rangeFormatting') then
                        mapkLspKey('<leader>fo', vim.lsp.buf.format, 'Format range of code', 'v')
                    end

                    if client.supports_method('textDocument/inlayHint') then
                        vim.lsp.inlay_hint.enable(true, { bufnr = event.buf})
                    end
                end
            })

            ---- configure language servers

            lspconfig['hls'].setup{}
            lspconfig['pyright'].setup{}
            lspconfig['bashls'].setup{}
            lspconfig['somesass_ls'].setup{}
            lspconfig['astro'].setup{}
            lspconfig['lua_ls'].setup{
                on_init = function(client)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc') then
                            return
                        end
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                        runtime = {
                            -- Tell the language server which version of Lua you're using
                            -- (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT'
                        },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME
                                -- Depending on the usage, you might want to add additional paths here.
                                -- "${3rd}/luv/library"
                                -- "${3rd}/busted/library",
                                }
                            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                            -- library = vim.api.nvim_get_runtime_file("", true)
                        }
                    })
                end,
                settings = {
                    Lua = {}
                }
            }
        end
    },

    -- ***************** completion *******************

    -- VS Code style snippets collection
    'rafamadriz/friendly-snippets',

    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*",
        dependencies = {
            'rafamadriz/friendly-snippets'
        },
        config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
            require('luasnip.loaders.from_vscode').lazy_load({ paths = './my-snippets' })
        end
    },

    -- luasnip completion source for nvim-cmp
    'saadparwaiz1/cmp_luasnip',

    -- other sources for nvim-cmp
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',

    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp-signature-help'
        },
        event = { 'InsertEnter' },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                sources = cmp.config.sources({
                    { name = 'luasnip' },
                    { name = 'path' },
                    {
                        name = 'buffer',
                        option = {
                            -- show completion from all open buffers
                            get_bufnrs = function()
                                return vim.api.nvim_list_bufs()
                            end
                        }
                    },
                    { name = 'nvim_lsp' }
                }),
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping(function(fallback)
                        if cmp.visible() and cmp.get_active_entry() then
                            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                        else
                            fallback()
                        end
                    end),
                    -- ['<CR>'] = cmp.mapping(function(fallback)
                    --     if cmp.visible() then
                    --         if luasnip.expandable() then
                    --             luasnip.expand()
                    --         else
                    --             cmp.confirm({ select = false })
                    --         end
                    --     else
                    --         fallback()
                    --     end
                    -- end),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' })
                })
            })
        end
    }
})

