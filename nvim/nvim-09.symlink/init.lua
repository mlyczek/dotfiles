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
keymap('n', '<Leader>q', ':qa<cr>')

-- better split navigation
keymap('n', '<C-J>', '<C-w><C-J>')
keymap('n', '<C-K>', '<C-w><C-K>')
keymap('n', '<C-L>', '<C-w><C-L>')
keymap('n', '<C-H>', '<C-w><C-H>')

-- disable arrow keys completely in insert mode
keymap('i', '<up>', '<nop>')
keymap('i', '<down>', '<nop>')
keymap('i', '<left>', '<nop>')
keymap('i', '<right>', '<nop>')

-- terminal
keymap('t', '<Esc>', '<C-\\><C-n>')
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
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.cmd([[colorscheme tokyonight]])
        end,
    },

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
                }
            }

            keymap("n", "<F5>", ":NvimTreeToggle<cr>", {silent = true, noremap = true})
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

    'tpope/vim-commentary',

    'tpope/vim-fugitive',

    -- 'airblade/vim-gitgutter',

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
            require('telescope').setup{}

            local builtin = require('telescope.builtin')
            keymap('n', '<leader>fe', builtin.find_files, {})
            keymap('n', '<leader>fb', builtin.buffers, {})
            keymap('n', '<leader>ff', builtin.live_grep, {})
            keymap('n', '<leader>gs', builtin.git_status, {})
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
        'neoclide/coc.nvim',
        branch = 'release',
        config = function()
            vim.g.coc_global_extensions = { 'coc-pyright', 'coc-tsserver' }

            function _G.check_back_space()
                local col = vim.fn.col('.') - 1
                return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
            end

            -- Use Tab for trigger completion with characters ahead and navigate
            -- NOTE: There's always a completion item selected by default, you may want to enable
            -- no select by setting `"suggest.noselect": true` in your configuration file
            -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
            -- other plugins before putting this into your config
            local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
            keymap("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
            keymap("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

            -- Make <CR> to accept selected completion item or notify coc.nvim to format
            -- <C-g>u breaks current undo, please make your own choice
            keymap("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
            -- Use <c-space> to trigger completion
            keymap("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

            -- Use K to show documentation in preview window
            function _G.show_docs()
                local cw = vim.fn.expand('<cword>')
                if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
                    vim.api.nvim_command('h ' .. cw)
                elseif vim.api.nvim_eval('coc#rpc#ready()') then
                    vim.fn.CocActionAsync('doHover')
                else
                    vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
                end
            end
            keymap("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

            keymap('n', '<C-b>', '<Plug>(coc-definition)', {silent = true})
            keymap('n', '<M-F7>', '<Plug>(coc-references)', {silent = true})
            keymap('n', '<S-F6>', '<Plug>(coc-rename)')
            keymap('n', '<M-CR>', '<Plug>(coc-codeaction-cursor)')
        end
    }
})

