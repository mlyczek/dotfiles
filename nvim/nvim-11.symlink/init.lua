-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- show line number and relative line number
vim.opt.number = true
vim.opt.relativenumber = true

-- disable swapfiles
-- vim.opt.swapfile = false
vim.opt.directory:prepend('$HOME/.vim-tmp//') -- directory to store swap files"
-- Persistent undo even after you close a file and re-open it
vim.opt.undofile = true

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
vim.opt.inccommand = 'split'

vim.opt.encoding = 'utf8'

-- Character to show before the lines that have been soft-wrapped
vim.opt.showbreak = '↪'
vim.opt.breakindent = true

-- Minimum lines to keep above and below cursor when scrolling
vim.opt.scrolloff = 10

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
    callback = function ()
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
    end
})
-- Go to insert mode by default to start typing command
autocmd('TermOpen', {
    group = term_settings,
    pattern = '*',
    command = 'startinsert'
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Filetype indentation
local file_type_indentation = augroup('file_type_indentation', { clear = true })
autocmd('Filetype', {
    group = file_type_indentation,
    pattern = { 'ruby', 'eruby' },
    callback = function ()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
    end
})
autocmd('Filetype', {
    group = file_type_indentation,
    pattern = { 'css' ,'scss', 'sass', 'less' },
    callback = function ()
        vim.opt_local.iskeyword:append('-')
    end
})

local spell_check = augroup('spell_check', { clear = true })
autocmd('Filetype', {
    group = spell_check,
    pattern = 'gitcommit',
    callback = function ()
        vim.opt_local.spell = true
    end
})

vim.keymap.set('n', '<Leader><space>', ':noh<cr>', { desc = 'Clear Highlight' })

-- close all
vim.keymap.set('n', '<Leader>q', ':qa<cr>', { desc = 'Close all' })

-- better split navigation
vim.keymap.set('n', '<C-J>', '<C-w><C-J>')
vim.keymap.set('n', '<C-K>', '<C-w><C-K>')
vim.keymap.set('n', '<C-L>', '<C-w><C-L>')
vim.keymap.set('n', '<C-H>', '<C-w><C-H>')

-- Split resizing
vim.keymap.set('n', '<M-,>', '<C-W>5<')
vim.keymap.set('n', '<M-.>', '<C-W>5>')
vim.keymap.set('n', '<M-->', '<C-W>5-')
vim.keymap.set('n', '<M-=>', '<C-W>5+')

-- disable arrow keys completely in insert mode
vim.keymap.set('i', '<up>', '<nop>')
vim.keymap.set('i', '<down>', '<nop>')
vim.keymap.set('i', '<left>', '<nop>')
vim.keymap.set('i', '<right>', '<nop>')

-- terminal
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')
vim.keymap.set('t', '<C-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-N><C-w>l')

require('config.lazy')

