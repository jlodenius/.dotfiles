return {
  "https://github.com/jlodenius/strider.nvim",
  config = function() vim.keymap.set("n", "K", '<cmd>lua require("strider").dec_to_bin()<CR>') end,
}
