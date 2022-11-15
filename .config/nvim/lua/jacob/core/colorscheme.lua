vim.g.nightflyTransparent = true
vim.opt.background = "dark"

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
