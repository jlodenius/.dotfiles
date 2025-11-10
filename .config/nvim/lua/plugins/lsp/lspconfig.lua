return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local border = {
      { "╭", "FloatBorder" },
      { "─", "FloatBorder" },
      { "╮", "FloatBorder" },
      { "│", "FloatBorder" },
      { "╯", "FloatBorder" },
      { "─", "FloatBorder" },
      { "╰", "FloatBorder" },
      { "│", "FloatBorder" },
    }
    local lspconfig = require("lspconfig")
    local lspconfigWindows = require("lspconfig.ui.windows")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap

    local on_attach = function(client, bufnr)
      -- keybind options
      local opts = { noremap = true, silent = true, buffer = bufnr }

      -- set border on hover
      -- :h vim.lsp.handlers.hover()
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = border,
      })

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = border,
      })

      vim.diagnostic.config({
        float = { border = "single" },
      })

      lspconfigWindows.default_options = {
        border = border,
      }

      -- keybinds
      keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts) -- go to declaration
      keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts) -- see definition and make edits in window
      keymap.set("n", "gv", ":vsplit | lua vim.lsp.buf.definition()<CR>", opts) -- open defining buffer in vertical split
      keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts) -- see available code actions
      keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts) -- smart rename
      keymap.set("n", "<leader>d", function() vim.diagnostic.open_float() end, opts) -- show  diagnostics for line
      -- lsp.buf.hover() is handled by strider.nvim
      -- keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts) -- show documentation for what is under cursor

      -- jump to diagnostics
      vim.keymap.set("n", "åd", function() vim.diagnostic.goto_next() end, opts)
      vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)

      -- typescript specific
      if client.name == "ts_ls" then
        keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
      end

      -- fix rust highlighting
      if client.name == "rust_analyzer" then client.server_capabilities.semanticTokensProvider = nil end
    end

    -- Setup LSP servers

    -- used to enable autocompletion in all LSPs
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- prisma
    lspconfig["prismals"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- html
    lspconfig["html"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- typescript
    lspconfig["ts_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- css
    lspconfig["cssls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- tailwindcss
    lspconfig["tailwindcss"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = {
              { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
              { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
            },
          },
        },
      },
    })

    -- python pyright
    lspconfig["pyright"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- svelte
    lspconfig["svelte"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- emmet
    lspconfig["emmet_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    })

    -- lua
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          telemetry = { enable = false },
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            checkThirdParty = false,
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    -- rust
    lspconfig["rust_analyzer"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "rust" },
      settings = {
        ["rust_analyzer"] = {
          cargo = {
            allFeatures = true,
          },
          completion = {
            postfix = {
              enable = false,
            },
          },
        },
      },
    })
  end,
}
