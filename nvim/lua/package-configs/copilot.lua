-- Disables copilot by default
vim.g.copilot_enabled = false

-- Toggle copilot
local copilot_toggle = function ()
    if vim.g.copilot_enabled then
        print("Github Copilot Off")
        vim.g.copilot_enabled = false
        return
    end

    print("Github Copilot On")
    vim.g.copilot_enabled = true
end

vim.keymap.set('n', '<leader>fa', copilot_toggle, { desc = 'Toggle/[F]ix Copilot [A]utocomplete' })
