return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    -- More settings & formatters
    -- https://github.com/stevearc/conform.nvim
    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        less = { "prettier" },
        scss = { "prettier" },
        markdown = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        lua = { "stylua" },
        python = { "black" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout = 500,
      },
    })

    vim.keymap.set(
      { "n", "v" },
      "<leader>cf",
      function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout = 500,
        })
      end,
      { desc = "Format file or range" }
    )
  end,
}
