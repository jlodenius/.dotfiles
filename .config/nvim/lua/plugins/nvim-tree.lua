return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local nvimtree = require("nvim-tree")

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

    -- keymaps
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
  end,
}
