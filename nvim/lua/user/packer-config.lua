-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
    -- Package manager
    use 'wbthomason/packer.nvim'

    use { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        run = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
    }

    use { -- Additional text objects via treesitter
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
    }

    use 'p00f/nvim-ts-rainbow' -- Nice multicolored nested parenthesis
    use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
    use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
    use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
    use 'sainnhe/sonokai' -- Colorscheme compatible with treesitter
    use 'edkolev/tmuxline.vim' -- Color config for tmux
    use 'nvim-lualine/lualine.nvim' -- Fancier statusline
    use 'akinsho/git-conflict.nvim' -- git conflict marker highlighting
    use 'cappyzawa/trim.nvim' -- trim trailing whitespace and lines
    use 'nvim-tree/nvim-tree.lua' -- file tree explorer

    -- Fuzzy Finder (files, lsp, etc)
    use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

    -- LSP setup
    use { -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        requires = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            'j-hui/fidget.nvim',

            -- Additional lua configuration, makes nvim stuff amazing
            'folke/neodev.nvim',

        },
    }
    -- Scala lang. server
    use {
        'scalameta/nvim-metals',
        requires = { "nvim-lua/plenary.nvim" }
    }

    use { -- Autocompletion
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp', -- Show data sent by lang. server
            'hrsh7th/cmp-buffer', -- Provide suggestions based on current file
            'hrsh7th/cmp-path', -- Give completions based on file system
            'hrsh7th/cmp-nvim-lsp', -- Show data sent by lang. server
            'hrsh7th/cmp-nvim-lua', -- Provides completions by lua API

            -- snippet support (built in lua)
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip'
        },
    }

    use {
	"windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    -- Firrtl syntax highlighting
    use { 'azidar/firrtl-syntax' }


    -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
    local has_plugins, plugins = pcall(require, 'custom.plugins')
    if has_plugins then
        plugins(use)
    end

    if is_bootstrap then
        require('packer').sync()
    end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
    print '=================================='
    print '    Plugins are being installed'
    print '    Wait until Packer completes,'
    print '       then restart nvim'
    print '=================================='
    return
end
