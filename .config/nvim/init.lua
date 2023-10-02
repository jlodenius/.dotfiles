-- setup
require("jacob.plugins-setup")

-- core
require("jacob.core.options")
require("jacob.core.keymaps")
require("jacob.core.colorscheme")

-- plugins
require("jacob.plugins.comment")
require("jacob.plugins.nvim-tree")
require("jacob.plugins.telescope")
require("jacob.plugins.nvim-cmp")
require("jacob.plugins.lsp.mason")
require("jacob.plugins.lsp.lspsaga")
require("jacob.plugins.lsp.lspconfig")
require("jacob.plugins.lsp.null-ls")
require("jacob.plugins.treesitter")
require("jacob.plugins.gitsigns")
require("jacob.plugins.lualine")
require("jacob.plugins.mini-surround")
require("jacob.plugins.mini-pairs")

-- highlight yank
vim.cmd([[
  augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=50}
  augroup END
]])

-- remove trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	command = [[%s/\s\+$//e]],
})

-- html highlighting in mjml files
vim.cmd([[
  autocmd BufNewFile,BufRead *.mjml set filetype=html
]])
