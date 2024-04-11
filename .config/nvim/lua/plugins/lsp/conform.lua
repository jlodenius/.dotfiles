return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    local utils = require("jabba-utils")

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
      formatters = {
        black = {
          cwd = require("conform.util").root_file({ "pyproject.toml" }),
        },
        prettier = {
          condition = function()
            local root_markers = { ".git", "package.json" }
            local target_files = { ".prettierrc", ".prettierrc.json" }
            return utils.root_has_file(utils.current_path(), root_markers, target_files)
          end,
          prepend_args = { "--no-semi", "--single-quote" },
        },
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
