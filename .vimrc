set nocompatible
filetype off

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'flazz/vim-colorschemes'

call vundle#end()
filetype plugin indent on

" Normal Vim settings
syntax on
set background=dark
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
set shiftwidth=4
set shiftround
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch
set backspace=indent,eol,start
set wildmenu

" Powerline Setup
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2
