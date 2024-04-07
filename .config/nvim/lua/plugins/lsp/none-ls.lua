return {
  "nvimtools/none-ls.nvim", -- configure formatters & linters
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "jay-babu/mason-null-ls.nvim",
  },
  config = function()
    local mason_null_ls = require("mason-null-ls")
    local null_ls = require("null-ls")
    local null_ls_utils = require("null-ls.utils")

    -- what to install
    mason_null_ls.setup({
      ensure_installed = {
        "prettier",
        "stylua",
        "eslint_d",
        "stylelint",
      },
    })

    -- to setup format on save
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
      -- add package.json as identifier for root (for typescript monorepos)
      root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
      sources = {
        -- FORMATTING
        null_ls.builtins.formatting.prettier.with({
          extra_args = { "--no-semi", "--single-quote" },
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
          condition = function(utils)
            -- only enable prettier if project has a .prettierrc
            -- leave .prettierrc empty to use above conf, otherwise .prettierrc will take precedence
            return utils.root_has_file({ ".prettierrc" })
          end,
        }),
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prismaFmt,
        null_ls.builtins.formatting.rustfmt,
        null_ls.builtins.formatting.black,

        -- DIAGNOSTICS
        null_ls.builtins.diagnostics.stylelint,
        null_ls.builtins.diagnostics.eslint_d.with({
          -- only enable eslint if project has a .eslintrc
          condition = function(utils)
            return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json", ".eslintrc" })
          end,
        }),
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.diagnostics.mypy,
      },

      -- format on save
      on_attach = function(current_client, bufnr)
        if current_client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                filter = function(client)
                  -- only use null-ls for formatting
                  return client.name == "null-ls"
                end,
                bufnr = bufnr,
              })
            end,
          })
        end
      end,
    })
  end,
}
