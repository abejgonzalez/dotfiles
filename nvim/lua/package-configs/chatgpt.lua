require("chatgpt").setup({
    api_key_cmd = "lpass show --notes openai-api-key"
})

vim.keymap.set('n', '<leader>fc', require('chatgpt').openChat, { desc = '[F]ind [C]hatGPT' })
