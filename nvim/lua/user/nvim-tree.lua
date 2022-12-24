-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup({
    open_on_setup = true,
    view = {
        adaptive_size = true,
    },
    filters = {
        dotfiles = true,
        custom = {
            '\\.o$',
            '\\.swp$',
            '\\.swo$',
            '\\.vcd$',
            '\\.fsdb$',
        }
    },
    renderer = {
        icons = {
            -- show = {
            --     file = false,
            --     folder = false,
            --     folder_arrow = false,
            --     git = false,
            -- }
        }
    }
})
