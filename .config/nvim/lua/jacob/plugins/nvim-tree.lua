local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  return
end

-- recommended settings from nvim-tree docs
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup({
  view = {
    width = 40,
    number = true,
    relativenumber = true,
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
})
