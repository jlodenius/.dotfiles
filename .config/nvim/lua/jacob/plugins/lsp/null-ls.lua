local setup, null_ls = pcall(require, "null-ls")
if not setup then
  return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({

  sources = {
    -- null_ls.builtins.formatting.prettier.with({
    --   extra_args = { "--no-semi", "--single-quote" },
    -- }),
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.eslint_d.with({
      -- only enable eslint if root has .eslintrc
      condition = function(utils)
        return utils.root_has_file(".eslintrc.js") or utils.root_has_file(".eslintrc.json")
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
              --  only use null-ls for formatting instead of lsp server
              return client.name == "null-ls"
            end,
            bufnr = bufnr,
          })
        end,
      })
    end
  end,
})
