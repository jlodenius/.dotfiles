local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  return
end


local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end


local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
  return
end


local keymap = vim.keymap


-- only enable these keybinds when lsp server is available
local on_attach = function(client, bufnr)
  -- keybind options
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- set keybinds
  keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
  keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
  keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
  keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
  keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
  keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
  keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
  keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
  keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
  keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
  keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
  keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

  -- typescript specific
  if client.name == "tsserver" then
    keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
  end
end



-- Setup LSP servers


-- used to enable autocompletion in all LSPs
local capabilities = cmp_nvim_lsp.default_capabilities()

-- html server
lspconfig["html"].setup({
  capabilities = capabilities,
  on_attach = on_attach
})

-- typescript server (slightly different setup because of plugin)
typescript.setup({
  server = {
    capabilities = capabilities,
    on_attach = on_attach
  }
})

-- css server
lspconfig["cssls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- tailwindcss server
lspconfig["tailwindcss"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- emmet language server
lspconfig["emmet_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})

-- lua server 
lspconfig["sumneko_lua"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = { 
    Lua = {
      -- make the language server recognize "vim" global
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- make language server aware of runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
})