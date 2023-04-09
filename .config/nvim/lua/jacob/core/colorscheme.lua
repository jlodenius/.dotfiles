require("rose-pine").setup({
  --- @usage 'main' | 'moon'
  dark_variant = "moon",
  bold_vert_split = false,
  dim_nc_background = false,
  disable_background = true,
  disable_float_background = true,
  disable_italics = false,

  --- @usage string hex value or named color from rosepinetheme.com/palette
  groups = {
    background = "base",
    panel = "surface",
    border = "highlight_med",
    comment = "muted",
    link = "iris",
    punctuation = "subtle",

    error = "love",
    hint = "iris",
    info = "foam",
    warn = "gold",

    headings = {
      h1 = "iris",
      h2 = "foam",
      h3 = "rose",
      h4 = "gold",
      h5 = "pine",
      h6 = "foam",
    },
    -- or set all headings at once
    -- headings = 'subtle'
  },

  -- Change specific vim highlight groups
  highlight_groups = {
    ColorColumn = { bg = "rose" },
  },
})

vim.cmd("colorscheme rose-pine")

local hl = function(thing, opts)
  vim.api.nvim_set_hl(0, thing, opts)
end

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
local telescopeBgColour = "#212121"

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
