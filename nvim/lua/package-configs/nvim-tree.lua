-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function my_on_attach(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set('n', '<CR>', api.node.open.tab, opts('Open: New Tab'))
    -- your removals and mappings go here
end

require('nvim-tree').setup({
    on_attach = my_on_attach,
    view = {
        adaptive_size = true,
    },
    git = {
        ignore = false
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
