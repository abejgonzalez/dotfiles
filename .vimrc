set nocompatible
filetype off

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle
Plugin 'VundleVim/Vundle.vim'

" FileTree Explorer
Plugin 'scrooloose/nerdtree.git'

" Syntax Checker
Plugin 'scrooloose/syntastic'

" AutoComplete
Plugin 'Valloric/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'

" Html Autocomplete
Plugin 'alvan/vim-closetag'

" Vim color config for Tmux
Plugin 'edkolev/tmuxline.vim'

" Vim colorschemes
Plugin 'flazz/vim-colorschemes'

" Scala Integrations
Plugin 'derekwyatt/vim-scala'

" Save (and update) ctags on file save
Plugin 'craigemery/vim-autotag'

call vundle#end()
filetype plugin indent on

" Normal Vim settings
syntax on
colorscheme molokai

set noshowmode
set showtabline=1
set nobackup
set ttimeoutlen=50
set cindent
set nowrap
set expandtab
set tabstop=4
set autoindent
set copyindent
set number
set relativenumber
set shiftwidth=4
set shiftround
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch
set backspace=indent,eol,start
set wildmenu
set showmatch
set encoding=utf-8
set number relativenumber

" For Syntax Checker
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" For HTML Autocomplete
let g:closetag_filenames = '*html,*xhtml,*phtml'

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

" Automatic search of ctags
set tags=tags;/

" Powerline Setup
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2
