return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local nvimtree = require("nvim-tree")

    vim.g.loaded = 1
    vim.g.loaded_netrwPlugin = 1

    local function my_on_attach(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- custom mappings
      vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
      vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
    end

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
      on_attach = my_on_attach,
    })

    -- toggle nvim-tree
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
  end,
}
