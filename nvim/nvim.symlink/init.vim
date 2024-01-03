" Clipboard settings, always use clipboard for all delete, yank, change, put
" operation, see https://goo.gl/YAHBbJ
set clipboard+=unnamedplus

" Split window below/right when creating horizontal/vertical windows
set splitbelow splitright

" Disable creating swapfiles, see https://goo.gl/FA6m6h
set noswapfile
set directory^=$HOME/.vim-tmp// " directory to store swap files"

" General tab settings
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " expand tab to spaces so that tabs are spaces

" show line number and relative line number
set number
set relativenumber

" Show current line where the cursor is
set cursorline

" Ignore case in general, but become case-sensitive when uppercase is present
set ignorecase smartcase

set encoding=utf8

" Set a ruler at column 121, see https://goo.gl/vEkF5i
" let &colorcolumn=join(range(131,999),",")

" Character to show before the lines that have been soft-wrapped
set showbreak=↪

" Minimum lines to keep above and below cursor when scrolling
set scrolloff=3

" Do not show mode on command line since vim-airline can show it
set noshowmode

" show some special characters
set list listchars=tab:>-,eol:¶,trail:·,nbsp:+

" Ask for confirmation when handling unsaved or read-only files
set confirm

" Do not use visual and errorbells
set visualbell noerrorbells t_vb=
" Persistent undo even after you close a file and re-open it
set undofile

set spelllang=en

" Align indent to next multiple value of shiftwidth. For its meaning,
" see http://tinyurl.com/y5n87a6m
set shiftround

" Do not add two space after a period when joining lines or formatting texts,
" see https://tinyurl.com/y3yy9kov
set nojoinspaces

" Do not use smart case in command line mode,
" extracted from https://goo.gl/vCTYdK
augroup dynamic_smartcase
    autocmd!
    autocmd CmdLineEnter : set nosmartcase
    autocmd CmdLineLeave : set smartcase
augroup END

augroup term_settings
    autocmd!
    " Do not use number and relative number for terminal inside nvim
    autocmd TermOpen * setlocal norelativenumber nonumber
    " Go to insert mode by default to start typing command
    autocmd TermOpen * startinsert
augroup END

" More accurate syntax highlighting? (see `:h syn-sync`)
augroup accurate_syn_highlight
    autocmd!
    autocmd BufEnter * :syntax sync fromstart
augroup END

" Filetype indentation
augroup diferent_indentation
    autocmd!
    autocmd Filetype ruby,eruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

    autocmd FileType css,scss,sass,less setlocal iskeyword+=-
augroup END

augroup spell_check
    autocmd!
    autocmd FileType gitcommit setlocal spell
augroup END

nnoremap <M-F7> :grep <C-R><C-W> *<CR>
nnoremap <leader><space> :noh<cr>
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" close all
nnoremap <Leader>q :qa<CR>

" Better split navigation¶
nnoremap <C-J> <C-W><C-J>¶
nnoremap <C-K> <C-W><C-K>¶
nnoremap <C-L> <C-W><C-L>¶
nnoremap <C-H> <C-W><C-H>¶

" Disable arrow keys completely in Insert Mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Sessions
set sessionoptions-=buffers
command Qs :ws<Bar>exe "mksession! " . v:this_session<CR>

" Terminal
:tnoremap <Esc> <C-\><C-n>
:tnoremap <C-h> <C-\><C-N><C-w>h
:tnoremap <C-j> <C-\><C-N><C-w>j
:tnoremap <C-k> <C-\><C-N><C-w>k
:tnoremap <C-l> <C-\><C-N><C-w>l

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
" Plug 'zchee/deoplete-jedi'
" Plug 'davidhalter/jedi-vim'
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'guns/vim-sexp'
Plug 'mhinz/vim-startify'
Plug 'goodell/vim-mscgen'
Plug 'ryanoasis/vim-devicons'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rodrigore/coc-tailwind-intellisense', {'do': 'npm install'}

Plug 'pearofducks/ansible-vim'

" Clojure
Plug 'luochen1990/rainbow'
Plug 'Olical/conjure'

" Haskell
Plug 'neovimhaskell/haskell-vim'

call plug#end()

""""""""""""""""""""""""""""""""" NERDTree """""""""""""""""""""""""""""""
" Reveal currently editted file in nerdtree widnow,
" see https://goo.gl/kbxDVK
nnoremap <silent> <M-F1> :NERDTreeFind<CR>
nnoremap <silent> <F5> :NERDTreeToggle<CR>

""""""""""""""""""""""""""""""""" Neomake """"""""""""""""""""""""""""""""
let g:neomake_open_list = 2
autocmd! BufWritePost *.js Neomake

"""""""""""""""""""""""""""" Airline settings """"""""""""""""""""""""""""
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=1

" Show buffer number for easier switching between buffer,
" see https://github.com/vim-airline/vim-airline/issues/1149
let g:airline#extensions#tabline#buffer_nr_show = 1

" Buffer number display format
let g:airline#extensions#tabline#buffer_nr_format = '%s. '

""""""""""""""""""""""""""""" Ag """""""""""""""""""""""""""""""""""""""""
if executable('ag')
    " Use Ag over grep
    set grepprg=ag\ --nogroup\ --nocolor
endif

"""""""""""""""""""""""""""""" UltiSnip """"""""""""""""""""""""""""""""""""
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsSnippetsDir = "~/.dotfiles/nvim/nvim.symlink/UltiSnips"

""""""""""""""""""""""""""""""""""" LaTeX-Box """""""""""""""""""""""""""""""""""
let g:LatexBox_Folding = 1

""""""""""""""""""""""""""""""""""""" FZF """""""""""""""""""""""""""""""""""""
nnoremap <leader>fe :Files<CR>

"""""""""""""""""""""""""""""""""""""" Python """"""""""""""""""""""""""""""""""""""
let g:python_highlight_all = 1

""""""""""""""""""""""""""""""""""" COC """""""""""""""""""""""""""""""""""
let g:coc_global_extensions = ['coc-json', 'coc-css', 'coc-phpls', 'coc-pyright', 'coc-tsserver']

" don't give |ins-completion-menu| messages.
set shortmess+=c

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

nmap <silent> <C-b> <Plug>(coc-definition)
nmap <silent> <M-F7> <Plug>(coc-references)
nmap <S-F6> <Plug>(coc-rename)

" Remap keys for apply code actions at the cursor position.
nmap <M-CR> <Plug>(coc-codeaction-cursor)
" Apply the most preferred quickfix action to fix diagnostic on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Remap keys for apply refactor code actions.
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

"""""""" Colorscheme """"""""
set termguicolors
set background=dark
colorscheme onedark

