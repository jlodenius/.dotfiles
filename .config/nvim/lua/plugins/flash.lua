return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  config = function()
    local wk = require("which-key")
    wk.register({
      l = {
        name = "Flash",
        s = { function() require("flash").jump() end, "Flash Jump" },
        t = { function() require("flash").treesitter() end, "Flash Treesitter" },
        a = { function() require("flash").treesitter_search() end, "Flash Treesitter Search" },
      },
    }, { prefix = "<leader>" })
  end,
}
