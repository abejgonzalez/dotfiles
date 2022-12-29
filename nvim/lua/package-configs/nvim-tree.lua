-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup({
    view = {
        adaptive_size = true,
    },
    filters = {
        dotfiles = false,
        custom = {
            '\\.o$',
            '\\.swp$',
            '\\.swo$',
            '\\.vcd$',
            '\\.fsdb$',
        }
    },
})
