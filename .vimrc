set t_Co=256
set nocompatible
filetype off
set rtp+=/scratch/abejgonza/config/.vim,/var/lib/vim/addons,/usr/share/vim/vimfiles,/usr/share/vim/vim74,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after

" Vundle
set rtp+=/scratch/abejgonza/config/.vim/bundle/Vundle.vim
call vundle#begin('/scratch/abejgonza/config/.vim/bundle')

" Vundle
Plugin 'VundleVim/Vundle.vim'

" FileTree Explorer
Plugin 'scrooloose/nerdtree.git'

" Vim color config for Tmux
Plugin 'edkolev/tmuxline.vim'

" Vim colorschemes
Plugin 'flazz/vim-colorschemes'

" Scala Integrations
Plugin 'derekwyatt/vim-scala'

" Save (and update) ctags on file save
Plugin 'craigemery/vim-autotag'

" Vim airline
Plugin 'vim-airline/vim-airline'

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

"au BufRead,BufNewFile *.fir set filetype=firrtl

" Automatic search of ctags
set tags=./tags;

" Automatically clear non-useful whitespace on write
autocmd BufWritePre * :%s/\s\+$//e

" Have ctags automatically check for all tags first and present them
nnoremap <C-]> g<C-]>

" Setup folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2
