vim.g.nightflyTransparent = true

local hl = function(thing, opts)
  vim.api.nvim_set_hl(0, thing, opts)
end

vim.cmd("colorscheme nightfly")

hl("LineNr", {
  fg = "#5EACD3",
})

hl("CursorLineNr", {
  bg = "None",
})

hl("CursorLine", {
  bg = "None",
})

hl("Visual", {
  bg = "#2B79A0",
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
