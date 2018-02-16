
call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-solarized8'
Plug 'luochen1990/rainbow'
Plug 'neomake/neomake'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'guns/vim-sexp'
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

set termguicolors
set background=dark
colorscheme gruvbox

set number
set relativenumber
set list
set cursorline
set expandtab       " Use spaces instead of tab
set tabstop=4       " Number of spaces to render a tab
set softtabstop=4
set shiftwidth=4    " Number of spaces to shift with < and >

" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.

" Airline settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Neomake
let g:neomake_open_list = 2
autocmd! BufWritePost *.js Neomake

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Ultisnips
let g:UltiSnipsSnippetsDir = "~/.dotfiles/nvim/nvim.symlink/UltiSnips"
let g:UltiSnipsEditSplit = "horizontal"

" Rainbow parentheses
let g:rainbow_active = 1

" LaTeX-Box
let g:LatexBox_Folding = 1

set noeb vb t_vb=

" Usefull mappings
vnoremap <leader>y "+y
vnoremap <leader>p "+p
nnoremap <leader>p "+p
nnoremap <leader>P "+P
nnoremap <leader><space> :noh<CR>

" NERDTree
nnoremap <F5> :NERDTreeToggle<CR>

" FZF
nnoremap <leader>fe :Files<CR>
