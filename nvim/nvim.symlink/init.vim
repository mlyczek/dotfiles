
call plug#begin()

" colorschemes
Plug 'mhartington/oceanic-next'
Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'joshdick/onedark.vim'
Plug 'KeitaNakamura/neodark.vim'
Plug 'rakr/vim-one'
Plug 'atelierbram/Base2Tone-vim'
Plug 'reedes/vim-colors-pencil'
Plug 'lifepillar/vim-solarized8'
Plug 'whatyouhide/vim-gotham'

Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neomake/neomake'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'vim-python/python-syntax'
Plug 'lumiliet/vim-twig'
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'guns/vim-sexp'
Plug 'mhinz/vim-startify'
Plug 'goodell/vim-mscgen'
Plug 'ryanoasis/vim-devicons'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Clojure
Plug 'clojure-vim/acid.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Vigemus/impromptu.nvim'
Plug 'clojure-vim/jazz.nvim'
Plug 'tpope/vim-fireplace'
Plug 'clojure-vim/async-clj-omni'
Plug 'luochen1990/rainbow'

call plug#end()

" Vim-one settings
let g:one_allow_italics = 1

" Neodark settings
let g:neodark#terminal_transparent = 1

set termguicolors
set background=dark
colorscheme onedark
" colorscheme ayu
" colorscheme neodark

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
let g:deoplete#sources#jedi#show_docstring = 1
call deoplete#custom#option('keyword_patterns', {'clojure': '[\w!$%&*+/:<=>?@\^_~\-\.#]*'})

" Ultisnips
let g:UltiSnipsSnippetsDir = "~/.dotfiles/nvim/nvim.symlink/UltiSnips"
let g:UltiSnipsEditSplit = "horizontal"

" Rainbow parentheses
" let g:rainbow_active = 1

" LaTeX-Box
let g:LatexBox_Folding = 1

" Python
let g:python_highlight_all = 1
let g:jedi#completions_enabled = 0 " Disable vim-jedi autocompletion because we have deoplete-jedi

set noeb vb t_vb=

" Usefull mappings
vnoremap <leader>y "+y
vnoremap <leader>p "+p
nnoremap <leader>p "+p
nnoremap <leader>P "+P
nnoremap <leader><space> :noh<CR>

" Better split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Resize windows using arrow keys
nnoremap <Left> :vertical resize -1<CR>
nnoremap <Right> :vertical resize +1<CR>
nnoremap <Up> :resize -1<CR>
nnoremap <Down> :resize +1<CR>

" Disable arrow keys completely in Insert Mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" NERDTree
nnoremap <F5> :NERDTreeToggle<CR>

" FZF
nnoremap <leader>fe :Files<CR>

" diff
nnoremap <leader>q :qa<CR>

" Sessions
set sessionoptions-=buffers
command Qs :ws<Bar>exe "mksession! " . v:this_session<CR>

" Terminal
:tnoremap <Esc> <C-\><C-n>
:tnoremap <C-h> <C-\><C-N><C-w>h
:tnoremap <C-j> <C-\><C-N><C-w>j
:tnoremap <C-k> <C-\><C-N><C-w>k
:tnoremap <C-l> <C-\><C-N><C-w>l

