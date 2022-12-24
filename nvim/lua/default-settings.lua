-- map leader key to something more reachable
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- normal vim settings
vim.o.termguicolors = true
vim.o.t_Co = 256 -- support 256 color mode (for iterm2)
vim.o.ttyfast = true -- speed up scrolling in vim
vim.o.showmode = false -- don't show '-- MODENAME --' in status bar (normally enabled with statusline plugins
vim.g.nobackup = true-- delete backup file on successful write
vim.o.ttimeoutlen = 500 -- set timeout for combination of keys
vim.wo.wrap = false -- don't wrap long lines
vim.o.number = true -- add line numbers
vim.o.relativenumber = true-- make current line number 0 and other line numbers relative to this line
vim.o.tabpagemax = 100 -- set max. number of vim tabs to open
vim.o.encoding = 'utf-8' -- set output shown in terminal to utf-8
vim.o.wildmenu = true -- set wildcard menu to only appear in status bar
vim.o.updatetime = 250 -- decrease update time

-- search options
vim.o.ignorecase = true -- case insensitive search
vim.o.smartcase = true -- when used with 'ignorecase' this allows for case-sensitive search if there is a capital letter in the search string
vim.o.hlsearch = true -- highlight search term
vim.o.incsearch = true -- show search matches as you type
vim.o.backspace = 'indent,eol,start' -- allow backspacing over everything in insert mode

-- setup folding
vim.o.foldmethod = 'indent'
vim.o.foldnestmax = 10
vim.wo.foldenable = false
vim.o.foldlevel = 2

vim.o.mouse = '' -- disable mouse

local vimpath = vim.fn.stdpath('config') .. '/lua/default-settings.vim'
vim.cmd('source ' .. vimpath)
