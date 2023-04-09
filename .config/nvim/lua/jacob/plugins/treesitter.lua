local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

treesitter.setup({
  highlight = { enable = true },
  indent = { enable = true },
  autotag = { enable = true },
  -- requires commentstring plugin (used to comment jsx/tsx)
  context_commentstring = { enable = true },
  -- Languages
  -- ADD MORE (https://github.com/nvim-treesitter/nvim-treesitter#supported-languages)
  ensure_installed = {
    "json",
    "javascript",
    "typescript",
    "tsx",
    "yaml",
    "html",
    "css",
    "markdown",
    "graphql",
    "bash",
    "lua",
    "vim",
    "dockerfile",
    "gitignore",
    "svelte",
  },
  auto_install = true,
  -- TODO: check out keybinds for selecting/jumping
  -- example setup https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L222
})
