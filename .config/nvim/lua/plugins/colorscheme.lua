return {
  {
    "xiyaowong/transparent.nvim",
    priority = 1001,
    config = function()
      local transparent = require("transparent")
      transparent.setup({
        extra_groups = {
          "NvimTreeNormal", -- NvimTree
        },
      })
      vim.cmd([[:TransparentEnable]])
    end,
  },
  {
    "savq/melange-nvim",
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme melange]])

      local hl = function(thing, opts) vim.api.nvim_set_hl(0, thing, opts) end

      hl("LineNr", {
        fg = "#5EACD3",
      })

      hl("CursorLineNr", {
        bg = "None",
      })

      hl("Cursor", {
        bg = "#FFFFFF",
      })

      hl("CursorLine", {
        bg = "None",
      })

      hl("Visual", {
        bg = "#655279",
      })

      -- Telescope
      local telescopeBgColour = "#152238"

      hl("TelescopeBorder", {
        bg = telescopeBgColour,
      })

      hl("TelescopeNormal", {
        bg = telescopeBgColour,
      })

      hl("TelescopeTitle", {
        bg = telescopeBgColour,
      })

      -- Nvim tree
      -- More options https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt#L1563
      hl("NvimTreeNormal", {
        bg = "None",
      })
    end,
  },
}
