local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

configs.setup({
    ensure_installed = {
	"bash",
	"c",
	"cmake",
	"cpp",
	-- "devicetree", -- requires special compilation
	"diff",
	"dockerfile",
	"git_rebase",
	"gitattributes",
	"gitcommit",
	-- "gitignore", -- requires special compilation
	"html",
	"json",
	"json5",
	"latex",
	"lua",
	"make",
	"markdown",
	"markdown_inline",
	"python",
	"regex",
	"scala",
	"verilog",
	"vim",
	"yaml",
    }, -- one of "all" or a list of languages
    ignore_install = { "" }, -- List of parsers to ignore installing
    highlight = {
	enable = true, -- false will disable the whole extension
	disable = { "" }, -- list of language that will be disabled
	additional_vim_regex_highlighting = true,
    },
    autopairs = {
	enable = true,
    },
    indent = { enable = true, disable = { "" } },
    rainbow = {
	enable = true,
	extended_mode = true,
	max_file_lines = nil,
    }
})
