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
"Plug 'scrooloose/nerdtree' " file tree explorer
Plug 'edkolev/tmuxline.vim' " color config for tmux
Plug 'vim-airline/vim-airline' " nice statusbar
Plug 'craigemery/vim-autotag' " save (and update) ctags on file save
"Plug 'github/copilot.vim' " enable github copilot
Plug 'nvim-lua/plenary.nvim' " see nextline
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' } " fuzzy finder
Plug 'akinsho/git-conflict.nvim' " git conflict marker highlighting
Plug 'lukas-reineke/indent-blankline.nvim' " indentation guides
Plug 'cappyzawa/trim.nvim' " trim trailing whitespace and lines
Plug 'nvim-tree/nvim-tree.lua' " file tree explorer
call plug#end()
" automatically calls
"syntax on " enable syntax highlighting
"filetype plugin indent on " allow auto-indenting depending on file type

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

" Have ctags automatically check for all tags first and present them
nnoremap <C-]> g<C-]>

" install lua side
lua require('config')
