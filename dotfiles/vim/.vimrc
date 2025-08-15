" ═══════════════════════════════════════════════════════════════
" Vim Configuration
" ═══════════════════════════════════════════════════════════════

" Basic Settings
set nocompatible              " Use Vim settings, not Vi
set encoding=utf-8            " Set encoding to UTF-8
set fileencoding=utf-8        " File encoding
set fileencodings=utf-8,cp949,euc-kr
set backspace=indent,eol,start " Backspace works normally
set history=1000              " Command history
set undolevels=1000           " Undo history
set autoread                  " Auto reload changed files
set clipboard=unnamed         " Use system clipboard
set mouse=a                   " Enable mouse support
set ttyfast                   " Faster redrawing
set lazyredraw                " Don't redraw while executing macros
set updatetime=250            " Faster completion
set timeoutlen=500            " Faster key sequence completion
set ttimeoutlen=10            " Faster escape key

" UI Settings
set number                    " Show line numbers
set relativenumber            " Relative line numbers
set cursorline                " Highlight current line
set showcmd                   " Show command in bottom bar
set showmatch                 " Highlight matching brackets
set wildmenu                  " Visual autocomplete for command menu
set wildmode=longest:full,full
set laststatus=2              " Always show status line
set ruler                     " Show cursor position
set colorcolumn=80,120        " Show column guides
set signcolumn=yes            " Always show sign column
set wrap                      " Wrap lines
set linebreak                 " Break lines at word boundaries
set scrolloff=8               " Keep 8 lines above/below cursor
set sidescrolloff=15          " Keep 15 columns left/right of cursor

" Search Settings
set hlsearch                  " Highlight search results
set incsearch                 " Incremental search
set ignorecase                " Case insensitive search
set smartcase                 " Case sensitive if uppercase present
set magic                     " Enable regex magic

" Indentation
set autoindent                " Copy indent from current line
set smartindent               " Smart autoindenting
set cindent                   " C-style indenting
set expandtab                 " Use spaces instead of tabs
set tabstop=4                 " Tab width
set softtabstop=4             " Tab width in insert mode
set shiftwidth=4              " Indentation width
set shiftround                " Round indent to multiple of shiftwidth

" File Type Specific Settings
autocmd FileType python setlocal ts=4 sts=4 sw=4 et
autocmd FileType javascript,typescript,javascriptreact,typescriptreact setlocal ts=2 sts=2 sw=2 et
autocmd FileType html,css,scss,sass setlocal ts=2 sts=2 sw=2 et
autocmd FileType json,yaml,yml setlocal ts=2 sts=2 sw=2 et
autocmd FileType markdown setlocal ts=2 sts=2 sw=2 et wrap spell
autocmd FileType go setlocal ts=4 sts=4 sw=4 noet
autocmd FileType makefile setlocal ts=4 sts=4 sw=4 noet
autocmd FileType c,cpp setlocal ts=4 sts=4 sw=4 et
autocmd FileType java setlocal ts=4 sts=4 sw=4 et

" Folding
set foldenable                " Enable folding
set foldlevelstart=10         " Open most folds by default
set foldnestmax=10            " Maximum nested fold
set foldmethod=indent         " Fold based on indent

" Backup and Swap
set nobackup                  " Don't create backup files
set nowritebackup             " Don't create backup before overwriting
set noswapfile                " Don't create swap files
set undofile                  " Persistent undo
set undodir=~/.vim/undo       " Undo files directory

" Create undo directory if it doesn't exist
if !isdirectory(expand('~/.vim/undo'))
    call mkdir(expand('~/.vim/undo'), 'p')
endif

" Syntax and Colors
syntax enable                 " Enable syntax highlighting
set termguicolors            " True color support
set background=dark          " Dark background

" Try to load a color scheme
try
    colorscheme desert
catch
    " Fallback to default
endtry

" Key Mappings
let mapleader = " "           " Set leader key to space

" Normal mode mappings
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>Q :q!<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Window resizing
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>
nnoremap <leader>= <C-w>=

" Buffer navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>bb :buffers<CR>

" Tab navigation
nnoremap <leader>tn :tabnext<CR>
nnoremap <leader>tp :tabprevious<CR>
nnoremap <leader>tc :tabnew<CR>
nnoremap <leader>td :tabclose<CR>

" Clear search highlighting
nnoremap <leader><space> :nohlsearch<CR>

" Quick save and quit
nnoremap <leader>s :w<CR>
inoremap <C-s> <Esc>:w<CR>a

" Move lines up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Better indenting
vnoremap < <gv
vnoremap > >gv

" Terminal mode mappings (Vim 8+/Neovim)
if has('terminal') || has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
endif

" Auto Commands
" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Return to last edit position when opening files
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif

" Highlight yanked text
if has('nvim')
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=200}
endif

" Status Line
set statusline=
set statusline+=%#PmenuSel#
set statusline+=\ %f           " File path
set statusline+=\ %m           " Modified flag
set statusline+=\ %r           " Read only flag
set statusline+=%=             " Right align
set statusline+=\ %y           " File type
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ [%{&fileformat}]
set statusline+=\ %p%%         " Percentage
set statusline+=\ %l:%c        " Line:Column
set statusline+=\ 

" Netrw Settings (File Explorer)
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 20
let g:netrw_altv = 1

" Toggle Netrw
nnoremap <leader>e :Lexplore<CR>
