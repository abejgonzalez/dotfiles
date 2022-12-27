--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- Helper to define mappings for LSP (mode, buffer and description)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

-- Setup neovim lua config file LSP
require('neodev').setup()

-- Setup mason so it can manage external tooling
require('mason').setup()

-- List of servers to install by default (and list of settings)
local servers = {
    sumneko_lua = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

-- Setup mason server capabilities + settings + attachment mappings
mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- Turn on lsp status information
require('fidget').setup()

-- nvim-cmp setup
local cmp = require("cmp")
local luasnip = require("luasnip")
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<C-p>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i" }),
        ["<C-e>"] = cmp.mapping(cmp.mapping.abort(), { "i" }),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
    },

    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "nvim_lua" },
        { name = "buffer" },
        { name = "path" },
    }),

    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                nvim_lsp = "",
                buffer = "",
            })[entry.source.name]
            vim_item.kind = ({
                Text = "",
                Method = "",
                Function = "",
                Constructor = "",
                Field = "",
                Variable = "",
                Class = "",
                Interface = "ﰮ",
                Module = "",
                Property = "",
                Unit = "",
                Value = "",
                Enum = "",
                Keyword = "",
                Snippet = "﬌",
                Color = "",
                File = "",
                Reference = "",
                Folder = "",
                EnumMember = "",
                Constant = "",
                Struct = "",
                Event = "",
                Operator = "ﬦ",
                TypeParameter = "",
            })[vim_item.kind] .. " " .. vim_item.kind
            return vim_item
        end,
    },
})

-- local feedkey = function(key, mode)
--     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
-- end

-- Insert '(' after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- nvim-metals (Scala LSP)

local Path = require("plenary.path")

local metals = require("metals")
local metals_config = metals.bare_config()
metals_config.on_attach = on_attach
metals_config.settings = {
    showImplicitArguments = true,
    excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}
metals_config.root_patterns = { "build.sbt", "build.sc" }

-- Find the last directory which contains one of the files/directories in 'metals_config.root_patterns'
metals_config.find_root_dir = function(patterns, startpath)
    local root_dir = nil
    local path = Path:new(startpath)
    for _, parent in ipairs(path:parents()) do
        for _, pattern in ipairs(patterns) do
            local target = Path:new(parent, pattern)
            if target:exists() then
                root_dir = parent
            end
        end
    end
    return root_dir
end

local metals_spinner_chars = {
    "⠋",
    "⠙",
    "⠸",
    "⠴",
    "⠦",
    "⠇",
}

-- Translate Metals status messages to a format that fidget.nvim can understand
local function metals_status_handler(_, status, ctx)
    -- Strip off trailing spinner character (which is 3 characters wide)
    if status.text then
        local maybe_spinner_char = status.text:sub(-3, -1)
        for _, v in pairs(metals_spinner_chars) do
            if v == maybe_spinner_char then
                status.text = status.text:sub(1, -4)
                break
            end
        end
    end

    -- https://github.com/scalameta/nvim-metals/blob/main/lua/metals/status.lua#L36-L50
    local val = {}
    if status.hide then
        val = { kind = "end" }
    elseif status.show then
        val = { kind = "begin", message = status.text, title = "Running" }
    elseif status.text then
        val = { kind = "report", message = status.text }
    else
        return
    end

    local info = { client_id = ctx.client_id }
    local msg = { token = "metals", value = val }
    -- call fidget progress handler
    vim.lsp.handlers["$/progress"](nil, msg, info)
end

local handlers = {}
handlers["metals/status"] = metals_status_handler

metals_config.init_options.statusBarProvider = "on"
metals_config.capabilities = capabilities
metals_config.handlers = handlers

-- Use special sbt script that understands env. vars
local sbtpath = vim.fn.stdpath('config') .. '/lua/sbt.sh'
metals_config.sbtScript = sbtpath

local lsp_metals = vim.api.nvim_create_augroup("lsp_metals", {})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "scala,sbt",
    callback = function()
        metals.initialize_or_attach(metals_config)
    end,
    group = lsp_metals,
})
