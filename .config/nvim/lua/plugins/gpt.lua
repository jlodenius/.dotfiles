-- Turned off for now, no GPT subscription
-- return {
--   "jackMort/ChatGPT.nvim",
--   event = "VeryLazy",
--   config = function()
--     local home = vim.fn.expand("$HOME")
--     require("chatgpt").setup({
--       api_key_cmd = "gpg --decrypt " .. home .. "/Development/Secrets/gpt.txt.asc",
--     })
--   end,
--   dependencies = {
--     "MunifTanjim/nui.nvim",
--     "nvim-lua/plenary.nvim",
--     "nvim-telescope/telescope.nvim",
--   },
-- }

-- Return empty table to avoid error
return {}
