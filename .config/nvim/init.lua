-- core
require("core.keymaps")
require("core.options")

-- open scratchpad
vim.api.nvim_create_user_command("Sp", "e ~/Notes/scratchpad.md", {})

-- set up lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    { import = "plugins" },
    { import = "plugins.lsp" },
  },
})

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

-- html hl for .mjml
vim.cmd([[
  autocmd BufNewFile,BufRead *.mjml set filetype=html
]])

-- toml hl for .snippets
vim.cmd([[
  autocmd BufNewFile,BufRead *.snippets set filetype=toml
]])
