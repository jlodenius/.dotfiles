local setup, null_ls = pcall(require, "null-ls")
if not setup then
  return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  sources = {
    -- FORMATTING
    null_ls.builtins.formatting.prettier.with({
      extra_args = { "--no-semi", "--single-quote" },
      condition = function(utils)
        -- only enable prettier if project has a .prettierrc
        -- leave .prettierrc empty to use above conf, otherwise .prettierrc will take precedence
        return utils.has_file(".prettierrc")
      end,
    }),
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prismaFmt,
    null_ls.builtins.formatting.rustfmt,
    -- DIAGNOSTICS
    null_ls.builtins.diagnostics.stylelint,
    null_ls.builtins.diagnostics.eslint_d.with({
      -- only enable eslint if project has a .eslintrc
      condition = function(utils)
        local hf = utils.has_file -- cant use root_has_file because of monorepos
        return hf(".eslintrc.js") or hf(".eslintrc.json") or hf(".eslintrc")
      end,
    }),
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
              -- only use null-ls or prisma for formatting
              -- add other clients here if necessary
              return client.name == "null-ls" or client.name == "prismals" or client.name == "rust_analyzer"
            end,
            bufnr = bufnr,
          })
        end,
      })
    end
  end,
})
