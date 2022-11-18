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
