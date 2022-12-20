" map leader key to something more reachable
let mapleader = " "

" vim plug options

" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '$XDG_CONFIG_HOME/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " parse file into tree for better highlighting, etc
Plug 'p00f/nvim-ts-rainbow' " nice multicolored nested parenthesis
Plug 'sainnhe/sonokai' " colorscheme compatible with treesitter
Plug 'scrooloose/nerdtree' " file tree explorer
Plug 'edkolev/tmuxline.vim' " color config for tmux
Plug 'vim-airline/vim-airline' " nice statusbar
Plug 'craigemery/vim-autotag' " save (and update) ctags on file save
"Plug 'github/copilot.vim' " enable github copilot
Plug 'nvim-lua/plenary.nvim' " see nextline
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' } " fuzzy finder
Plug 'akinsho/git-conflict.nvim' " git conflict marker highlighting
call plug#end()
" automatically calls
"syntax on " enable syntax highlighting
"filetype plugin indent on " allow auto-indenting depending on file type

" colorscheme options
if has('termguicolors')
    set termguicolors
endif
let g:sonokai_style = 'andromeda'
let g:sonokai_better_performance = 1
colorscheme sonokai

" Normal Vim settings
set t_Co=256 " support 256 color mode (for iterm2)
set ttyfast " speed up scrolling in vim
set noshowmode " don't show '-- MODENAME --' in status bar (normally enabled with statusline plugins
set nobackup " delete backup file on successful write
set ttimeoutlen=500 " set timeout for combination of keys
set nowrap " don't wrap long lines
set number " add line numbers
set relativenumber " make current line number 0 and other line numbers relative to this line
set tabpagemax=100 " set max. number of vim tabs to open
set encoding=utf-8 " set output shown in terminal to utf-8
set wildmenu " set wildcard menu to only appear in status bar

" tab/indentation settings
set tabstop=4 " number of columns occupied by a tab
set softtabstop=4 " see multiple spaces as tabstops so <BS> works
set expandtab " convert tabs to whitespace
set shiftwidth=4 " width for autoindents
set shiftround " use multiple of shiftwidth when indenting with '<' and '>'

" search options
set ignorecase " case insensitive search
set smartcase " when used with 'ignorecase' this allows for case-sensitive search if there is a capital letter in the search string
set hlsearch " highlight search term
set incsearch " show search matches as you type
set backspace=indent,eol,start " allow backspacing over everything in insert mode

" For Chisel syntax highlighting
augroup ft_scala
    autocmd!
    autocmd Syntax scala syn keyword chiselKeyword when elsewhen otherwise
    autocmd Syntax scala hi link chiselKeyword Keyword
    autocmd Syntax scala syn match chiselFunction /\<printf\>/
    autocmd Syntax scala hi link chiselFunction Function
    autocmd Syntax scala syn match chiselOperator "==="
    autocmd Syntax scala syn match chiselOperator "=/="
    autocmd Syntax scala syn match chiselOperator "+%"
    autocmd Syntax scala syn match chiselOperator "+&"
    autocmd Syntax scala syn match chiselOperator "-%"
    autocmd Syntax scala syn match chiselOperator "-&"
    autocmd Syntax scala hi link chiselOperator Special
augroup end

au BufRead,BufNewFile *.fir set filetype=firrtl

" Automatically clear non-useful whitespace on write
autocmd BufWritePre * :%s/\s\+$//e

" Have ctags automatically check for all tags first and present them
nnoremap <C-]> g<C-]>

" Setup folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Setup tmuxline to not show special characters
let g:tmuxline_powerline_separators = 0

" Have nerdtree show hidden files
let NERDTreeShowHidden=1

" install lua side
lua require('config')
