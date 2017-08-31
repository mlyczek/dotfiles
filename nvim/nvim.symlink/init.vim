
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

" Rainbow parentheses
let g:rainbow_active = 1

set noeb vb t_vb=

" Usefull mappings
vnoremap <leader>y "+y
nnoremap <leader><space> :noh<CR>

" NERDTree
nnoremap <F5> :NERDTreeToggle<CR>

" FZF
nnoremap <leader>fe :Files<CR>
